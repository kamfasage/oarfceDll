####################################################################
###########       Copyright (c) 2016 BigSQL           ##############
####################################################################

import os, util, subprocess, sys
import time
import json
from ConsoleLogger import ConsoleLogger

component_name = "bam2"

service_name = "bigsql.bam2"
#prior to version 1.4.1. use this to delete the old service_name
#for a few versions, until we feel confident that no old installs exist
old_service_name = "bam"

PGC_HOME = os.getenv('PGC_HOME', '')
PGC_LOGS = os.getenv('PGC_LOGS', '')

# Initialize the ConsoleLogger to redirect the console output log file
sys.stdout = ConsoleLogger()

homedir = os.path.join(PGC_HOME, component_name)

logdir = os.path.join(homedir, 'logs')

try:
    with open(os.path.join(PGC_HOME,'conf','bam_config.json'), 'r+') as _file:
        BamConfigData = json.loads(_file.read())
        if "test" in BamConfigData:
            if BamConfigData.get('test'):
                util.set_value("GLOBAL", "STAGE", "test")
            del BamConfigData["test"]
            with open(os.path.join(PGC_HOME,'conf','bam_config.json'), 'w') as bfile:
                json.dump(BamConfigData, bfile)
except Exception as e:
    pass


def check_is_service_installed(svcName):
    import win32serviceutil

    is_service_installed = False
    try:
        win32serviceutil.QueryServiceStatus(svcName)
        is_service_installed = True
    except:
        is_service_installed = False
    return is_service_installed


def delete_service_win(svcName):
    if check_is_service_installed(svcName):
        sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
        util.system(sc_path + " delete " + svcName, is_admin=True)


def create_service_win(svcName):
    if check_is_service_installed(svcName):
        pass
    else:
        sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
        util.system(homedir + os.sep + "bin" + os.sep + "create_service.bat", is_admin=True)
        sdshow = subprocess.Popen(sc_path + " sdshow " + svcName, stdout=subprocess.PIPE).communicate()
        sd_value = sdshow[0].lstrip('\n').strip()
        new_sd_value = 'A;;RPWPDTLO;;;S-1-1-0'  # + sid_value
        # set the service descriptor for the bam with current user SID
        sd_set_cmd = sc_path + " sdset " + svcName + " {}({})".format(sd_value, new_sd_value)
        util.system(sd_set_cmd, is_admin=True)


if util.get_platform() == "Windows":
    delete_service_win(old_service_name)
    create_service_win(service_name)
elif util.get_platform() == "Darwin":
    import plistlib
    if not os.path.isdir(logdir):
        os.mkdir(logdir)
    plist_conf_dir = os.path.join(PGC_HOME, 'conf', 'plist')
    if not os.path.isdir(plist_conf_dir):
        os.mkdir(plist_conf_dir)
    launch_dir = os.path.join(os.getenv("HOME", "~"), "Library", "LaunchAgents")
    if not os.path.isdir(launch_dir):
        os.mkdir(launch_dir)
    file_name = service_name + ".plist"
    plist_filename = os.path.join(plist_conf_dir, file_name)
    plist_dict = {}
    plist_dict['Label'] = service_name
    plist_dict['Disabled'] = "false"
    plist_dict['EnvironmentVariables'] = {}
    plist_dict['EnvironmentVariables']['PGC_HOME'] = PGC_HOME
    plist_dict['EnvironmentVariables']['PGC_LOGS'] = PGC_LOGS
    plist_dict['EnvironmentVariables']['PYTHONPATH'] = os.path.join(PGC_HOME, "hub", "scripts", "lib")
    program_path = os.path.join(homedir, 'bin', 'start_crossbar.sh')
    plist_dict['ProgramArguments'] = [program_path]
    plist_dict['RunAtLoad'] = False
    plist_dict['KeepAlive'] = False
    plist_dict['ServiceDescription'] = 'BigSQL Manager'
    plist_dict['StandardErrorPath'] = logdir + os.sep + "bamlaunch.err"
    plist_dict['StandardOutPath'] = logdir + os.sep + "bamlaunch.out"

    plistlib.writePlist(plist_dict, plist_filename)

    # sym link from conf dir to launch dir
    plist_link_file = os.path.join(launch_dir, file_name)
    if os.path.exists(plist_link_file):
        launctl_unload_cmd = "launchctl unload " + plist_link_file
        subprocess.Popen(launctl_unload_cmd, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True).communicate()
        remove_existing_plist_link = "rm " + os.path.join(launch_dir, file_name)
        subprocess.Popen(remove_existing_plist_link, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True).communicate()

    sym_link_command = "ln -sfv {} {}".format(plist_filename, launch_dir)
    symlink_output = subprocess.Popen(sym_link_command, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, shell=True).communicate()

    # load the service
    launctl_load_cmd = "launchctl load " + plist_link_file
    launctl_load_output = subprocess.Popen(launctl_load_cmd, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, shell=True).communicate()
else:
    pass

if sys.version_info < (2, 7):
    print "You need python 2.7 or later to run " + component_name
    sys.exit(1)

util.check_python_tools_ssl(component_name)
