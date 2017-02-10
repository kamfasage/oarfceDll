####################################################################
###########       Copyright (c) 2016 BigSQL           ##############
####################################################################

import os, util, subprocess
import sys
from ConsoleLogger import ConsoleLogger

component_name = "bam2"

PGC_HOME = os.getenv('PGC_HOME', '')

homedir = os.path.join(PGC_HOME, component_name)

# Initialize the ConsoleLogger to redirect the console output log file
sys.stdout = ConsoleLogger()

if not util.has_admin_rights():
    print "You must be an administrator/root to stop bam2."
    sys.exit(0)

print "stopping bam2"

if util.get_platform() == "Windows":
    import win32serviceutil, win32service
    sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
    service_name = "bigsql.bam2"
    cmd = sc_path + ' stop ' + service_name
    process_output = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True).communicate()
    print process_output[0]
    try:
        win32serviceutil.WaitForServiceStatus(service_name, win32service.SERVICE_STOPPED, 10)
    except win32service.error as exc:
        print("Error stopping service: %s" % exc.strerror)
        err = exc.winerror
        sys.exit(1)
elif util.get_platform() == "Darwin":
    launctl_load_cmd = "launchctl stop bigsql.bam2"
    os.system(launctl_load_cmd)
else:
    subprocess.Popen("pkill -f " + homedir + os.sep + "bin" + os.sep + "start_crossbar.py", shell=True)
