####################################################################
###########       Copyright (c) 2016 BigSQL           ##############
####################################################################

import os, util, subprocess, sys
import urllib2
import time
from ConsoleLogger import ConsoleLogger

component_name = "bam2"

PGC_HOME = os.getenv('PGC_HOME', '')

# Initialize the ConsoleLogger to redirect the console output log file
sys.stdout = ConsoleLogger()

if sys.version_info < (2, 7):
    print "You need python 2.7 or later to run " + component_name
    sys.exit(0)


homedir = os.path.join(PGC_HOME, component_name)

logdir = os.path.join(homedir, 'logs')

if not util.has_admin_rights():
    print "You must be an administrator/root to start bam2."
    sys.exit(0)

if not util.check_python_tools_ssl(component_name):
    sys.exit(0)

if util.get_platform() == "Windows":
    service_name = "bigsql.bam2"
    import win32serviceutil, win32service
    is_service_installed = False
    try:
        win32serviceutil.QueryServiceStatus(service_name)
        is_service_installed = True
    except:
        is_service_installed = False
    sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
    cmd = sc_path + ' start ' + service_name
    if not is_service_installed:
        util.system(homedir + os.sep + "bin" + os.sep + "create_service.bat", is_admin=True)
        sdshow = subprocess.Popen(sc_path + " sdshow " + service_name, stdout=subprocess.PIPE).communicate()
        sd_value = sdshow[0].lstrip('\n').strip()
        new_sd_value = 'A;;RPWPDTLO;;;S-1-1-0'  # + sid_value
        # set the service descriptor for the bam with current user SID
        sd_set_cmd = sc_path + " sdset {} {}({})".format(service_name, sd_value, new_sd_value)
        util.system(sd_set_cmd, is_admin=True)
    process_output = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True).communicate()
    print process_output[0]
    print "bam2 starting on port 8050"
    try:
        status = win32serviceutil.WaitForServiceStatus(service_name, win32service.SERVICE_RUNNING, 10)
    except win32service.error as exc:
        print("Error starting service: %s" % exc.strerror)
        err = exc.winerror
        sys.exit(1)
    #util.system(cmd, is_admin=True)
elif util.get_platform() == "Darwin":
    if not os.path.isdir(logdir):
        os.mkdir(logdir)
    launctl_load_cmd = "launchctl start bigsql.bam2"
    os.system(launctl_load_cmd)
    print "bam2 starting on port 8050"
else:
    cmd = "PYTHONPATH=" + homedir + os.sep + "lib" + " python " + homedir + os.sep + "bin" + os.sep + "start_crossbar.py start --cbdir " + homedir + os.sep + "bin" + " --loglevel info --logtofile  --logdir " + logdir + " &"
    os.system(cmd)
    print "bam2 starting on port 8050"

i=10
is_started = False
while i > 0:
    i -= 1
    time.sleep(1)
    try:
        check_url = urllib2.urlopen('http://localhost:8050')
        if check_url.code == 200:
            is_started = True
            break
    except urllib2.HTTPError as e:
        pass
    except urllib2.URLError as e:
        pass
    except Exception as e:
        pass

if is_started:
    print "bam2 started on port 8050."
else:
    print "Unable to start bam2."
