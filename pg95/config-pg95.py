####################################################################
#########            Copyright 2016 BigSQL               ###########
####################################################################

import argparse, util, sys, os, tempfile, json, subprocess

pgver = "pg95"
dotver  = pgver[2] + "." + pgver[3]

PGC_HOME = os.getenv('PGC_HOME', '')
PGC_LOGS = os.getenv('PGC_LOGS', '')

pg_home = os.path.join(PGC_HOME, pgver)
homedir = os.path.join(PGC_HOME, pgver)
logdir = os.path.join(homedir, pgver)

parser = argparse.ArgumentParser()
parser.add_argument("--port", type=int, default=0)
parser.add_argument("--autostart", choices=["on", "off"])
parser.add_argument("--datadir", type=str, default="")
parser.add_argument("--logdir", type=str, default="")
parser.add_argument("--svcname", type=str, default="")

args = parser.parse_args()

isJson = os.getenv("isJson", None)

autostart = util.get_column('autostart', pgver)
app_datadir = util.get_comp_datadir(pgver)
port = util.get_comp_port(pgver)

is_running = False

if app_datadir != "" and util.is_socket_busy(int(port), pgver):
  is_running = True
  msg = "You cannot change the configuration when the server is running."
  if isJson:
    jsonMsg = {}
    jsonMsg['status'] = "error"
    jsonMsg['component'] = pgver
    jsonMsg['msg'] = msg
    print json.dumps([jsonMsg])
  else:
    print msg

  sys.exit(0)


## PORT ################################################
if args.port > 0:
  rc = util.update_postgresql_conf(pgver, args.port, False)
  if rc > 0:
    sys.exit(rc)

## DATADIR, LOGDIR & SVCNAME ###########################
if args.datadir > '':
  util.set_column("datadir", pgver, args.datadir)

if args.logdir > '':
  util.set_column("logdir", pgver, args.logdir)

if args.svcname > '':
  util.set_column("svcname", pgver, args.svcname)

## AUTOSTART ###########################################
if args.autostart is None:
  sys.exit(0)

if util.get_platform() == "Linux":
  msg = "Autostart not supported for Linux at this time"
  if isJson:
    jsonMsg = {}
    jsonMsg['status'] = "error"
    jsonMsg['component'] = pgver
    jsonMsg['msg'] = msg
    print json.dumps([jsonMsg])
  else:
    print msg
  sys.exit(0)

if autostart == args.autostart:
  msg = pgver + " is already configured to auto start " + args.autostart
  if isJson:
    jsonMsg = {}
    jsonMsg['status'] = "error"
    jsonMsg['component'] = pgver
    jsonMsg['msg'] = msg
    print json.dumps([jsonMsg])
  else:
    print msg
  sys.exit(0)


if util.get_platform() == "Windows":
  datadir   = util.get_column('datadir', pgver)
  svcname   = util.get_column('svcname', pgver, 'PostgreSQL ' + dotver + ' Server')
  cmd_file = tempfile.mktemp(".bat")
  fh = open(cmd_file, "w")
  fh.write('sc stop "' + svcname + '"\n')
  fh.write('sc delete "' + svcname + '"\n')
  if args.autostart == "on":
    startMsg = "Creating PostgreSQL "+ pgver +" service"
    if isJson:
      jsonMsg = {}
      jsonMsg['status'] = "wip"
      jsonMsg['component'] = pgver
      jsonMsg['msg'] = startMsg
      print json.dumps([jsonMsg])
    else:
      print startMsg
    fh.write('set SVC_NAME="' + svcname + '"\n')
    fh.write('set SVC_DESC="The worlds most advanced open source database."\n')
    fh.write('set DATA_DIR="'+datadir+'"\n')
    fh.write('set PG_VER=' + pgver + '\n')
    fh.write(pg_home + os.sep + 'create_service.bat\n')
  fh.close()
  util.system(cmd_file, is_admin=True)

elif util.get_platform() == "Darwin":

  import plistlib
  if not os.path.isdir(logdir):
    os.mkdir(logdir)
  plist_conf_dir = os.path.join(PGC_HOME, 'conf', 'plist')
  if not os.path.isdir(plist_conf_dir):
    os.mkdir(plist_conf_dir)
  LAUNCHDIR = os.path.join(os.getenv("HOME", "~"), "Library", "LaunchAgents")
  if not os.path.isdir(LAUNCHDIR):
    os.mkdir(LAUNCHDIR)
  file_name = "bigsql."+ pgver +".plist"
  plist_filename = os.path.join(plist_conf_dir, file_name)
  plist_dict = {}
  plist_dict['Label'] = "bigsql." + pgver
  plist_dict['Disabled'] = "false"
  plist_dict['EnvironmentVariables'] = {}
  plist_dict['EnvironmentVariables']['PGC_HOME'] = PGC_HOME
  plist_dict['EnvironmentVariables']['PGC_LOGS'] = PGC_LOGS
  plist_dict['EnvironmentVariables']['PYTHONPATH'] = os.path.join(PGC_HOME, "hub", "scripts", "lib")
  program_path = os.path.join(homedir, 'run-pgctl.py')
  plist_dict['ProgramArguments'] = ['python', program_path]
  plist_dict['RunAtLoad'] = True
  plist_dict['KeepAlive'] = False
  plist_dict['ServiceDescription'] = 'PostgreSQL ' + dotver + ' Server'
  plist_dict['StandardErrorPath'] = logdir + os.sep + pgver + "launch.err"
  plist_dict['StandardOutPath'] = logdir + os.sep + pgver + "launch.out"

  plistlib.writePlist(plist_dict, plist_filename)

  # sym link from conf dir to launch dir
  plist_link_file = os.path.join(LAUNCHDIR, file_name)

  if os.path.exists(plist_link_file):
    launctl_unload_cmd = "launchctl unload " + plist_link_file
    subprocess.Popen(launctl_unload_cmd, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, shell=True).communicate()
    remove_existing_plist_link = "rm " + os.path.join(LAUNCHDIR, file_name)
    subprocess.Popen(remove_existing_plist_link, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, shell=True).communicate()

  sym_link_command = "ln -sfv {} {}".format(plist_filename, LAUNCHDIR)
  symlink_output = subprocess.Popen(sym_link_command, stdout=subprocess.PIPE,
                   stderr=subprocess.PIPE, shell=True).communicate()

  if args.autostart == 'on' :
    startMsg = "Creating PostgreSQL "+ pgver +" service"
    if isJson:
      jsonMsg = {}
      jsonMsg['status'] = "wip"
      jsonMsg['component'] = pgver
      jsonMsg['msg'] = startMsg
      print json.dumps([jsonMsg])
    else:
      print startMsg

    # load the service
    launctl_load_cmd = "launchctl load " + plist_link_file
    launctl_load_output = subprocess.Popen(launctl_load_cmd, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE, shell=True).communicate()
  else:
    # Unload the service 
    launctl_unload_cmd = "launchctl unload " + plist_link_file
    subprocess.Popen(launctl_unload_cmd, stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE, shell=True).communicate()
    remove_existing_plist_link = "rm " + os.path.join(LAUNCHDIR, file_name)
    subprocess.Popen(remove_existing_plist_link, stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE, shell=True).communicate()

util.set_column("autostart", pgver, args.autostart)
msg = pgver + " has been configured to auto start " + args.autostart

if isJson:
  jsonMsg = {}
  jsonMsg['status'] = "completed"
  jsonMsg['component'] = pgver
  jsonMsg['msg'] = msg
  print json.dumps([jsonMsg])
else:
  print msg

sys.exit(0)
