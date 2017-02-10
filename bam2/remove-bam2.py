####################################################################
###########       Copyright (c) 2016 BigSQL           ##############
####################################################################

import os, util, subprocess, sys
import time
from ConsoleLogger import ConsoleLogger

component_name = "bam2"

PGC_HOME = os.getenv('PGC_HOME', '')
PGC_LOGS = os.getenv('PGC_LOGS', '')

# Initialize the ConsoleLogger to redirect the console output log file
sys.stdout = ConsoleLogger()

homedir = os.path.join(PGC_HOME, component_name)

logdir = os.path.join(homedir, 'logs')

if not util.has_admin_rights():
    print "You must be an administrator/root to remove bam2."
    sys.exit(0)

if util.get_platform() == "Windows":
    import win32serviceutil
    is_service_installed = False
    try:
        win32serviceutil.QueryServiceStatus('bam')
        is_service_installed = True
    except:
        is_service_installed = False
    sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
    if is_service_installed:
        util.system(sc_path+" delete bam", is_admin=True)
elif util.get_platform() == "Darwin":
    plist_conf_dir = os.path.join(PGC_HOME, 'conf', 'plist')
    launch_dir = os.path.join(os.getenv("HOME", "~"), "Library", "LaunchAgents")
    file_name = "bigsql.bam2.plist"
    plist_filename = os.path.join(plist_conf_dir, file_name)
    plist_link_file = os.path.join(launch_dir, file_name)
    if os.path.exists(plist_link_file):
        launctl_unload_cmd = "launchctl unload " + plist_link_file
        subprocess.Popen(launctl_unload_cmd, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True).communicate()
        remove_existing_plist_link = "rm " + os.path.join(launch_dir, file_name)
        subprocess.Popen(remove_existing_plist_link, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True).communicate()
        remove_existing_plist_file = "rm " + plist_filename
        subprocess.Popen(remove_existing_plist_file, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True).communicate()
else:
    pass
