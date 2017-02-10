
####################################################################
#########            Copyright 2016 BigSQL               ###########
####################################################################

import argparse, util, os, sys, shutil, subprocess, getpass, json

PGC_HOME = os.getenv('PGC_HOME', '')

sys.path.append(os.path.join(PGC_HOME, 'hub', 'scripts', 'lib'))

from ConsoleLogger import ConsoleLogger


def fatal_error(p_msg):
  if isJson:
    sys.stdout = previous_stdout
    jsonMsg = {}
    jsonMsg['status'] = "error"
    jsonMsg['msg'] = p_msg
    print json.dumps([jsonMsg])
  else:
    print p_msg
  sys.exit(1)
  return

#######################################################
##                     MAINLINE                      ##
#######################################################
pgver = "pg95"

app_datadir = util.get_comp_datadir(pgver)
update_install_date=False
if app_datadir == "":
  update_install_date=True


parser = argparse.ArgumentParser()
parser.add_argument("--datadir", type=str, default="")
parser.add_argument("--port", type=int, default=0)
parser.add_argument("--options", type=str, default="")
args = parser.parse_args()

# Initialize the ConsoleLogger to redirect the console output log file
previous_stdout = sys.stdout
sys.stdout = ConsoleLogger()

isJson = os.getenv("isJson", None)

pg_home = os.path.join(PGC_HOME, pgver)

print " "
print "## Initializing " + pgver + " #######################"

## PORT ###############################################
if args.port > 0:
  i_port = args.port
else:
  i_port =  util.get_avail_port("PG Port", 5432, pgver)

## DATA ###############################################
data_root = os.path.join(PGC_HOME, "data")
if not os.path.isdir(data_root):
  os.mkdir(data_root)
if args.datadir == "":
  pg_data = os.path.join(data_root, pgver)
else:
  pg_data = args.datadir

if os.path.isdir(pg_data):
  if not os.listdir(pg_data) == []:
    fatal_error("ERROR: datadir not empty - " + pg_data)
else:
  os.mkdir(pg_data)


## PASSWD #############################################
pgpass_file = pg_home + os.sep + ".pgpass"
if os.path.isfile(pgpass_file):
  file = open(pgpass_file, 'r')
  line = file.readline()
  pg_password = line.rstrip()
  file.close()
else:
  pg_password = util.get_superuser_passwd()
  file = open(pgpass_file, 'w')
  file.write(pg_password + '\n')
  file.close()
os.chmod(pgpass_file, 0600)


## PERMISSIONS ########################################
print "Giving current user permission to data dir"
if util.get_platform() != "Windows":
  os.chmod(pg_data, 0600)
else:
  cur_user = getpass.getuser()
  batcmd = 'icacls "' + pg_data + '" /grant "' + cur_user + \
           '":(OI)(CI)F'
  err = os.system(batcmd)
  if err:
    msg = "ERROR: Unable to set permissions on data dir " + \
          " (err=" + str(err) + ")"
    fatal_error(msg)

## LOGS ###############################################
data_root_logs = os.path.join(data_root, "logs")
if not os.path.isdir(data_root_logs):
  os.mkdir(data_root_logs)
pg_log = os.path.join(data_root_logs, pgver)
if not os.path.isdir(pg_log):
  os.mkdir(pg_log)

if util.get_platform() == "Windows":
  print "Giving current user permission to log dir"
  cur_user = getpass.getuser()
  batcmd = 'icacls "' + pg_log + '" /grant "' + cur_user + \
           '":(OI)(CI)F'
  err = os.system(batcmd)
  if err:
    msg = "ERROR: Unable to set permissions on log dir " + \
          " (err=" + str(err) + ")"
    fatal_error(msg)

logfile = os.path.join(pg_log, "install.log")


## INITDB #############################################
print ' '
print 'Initializing Postgres DB at:'
print '   -D "' + pg_data + '" ' + args.options
initdb_cmd = os.path.join(pg_home, 'bin', 'initdb')
batcmd = initdb_cmd + ' -U postgres -A md5 ' + args.options + \
         ' -D "' + pg_data + '" ' + \
         '--pwfile="' + pgpass_file + '" > "' + logfile + '" 2>&1'
err = os.system(batcmd)
os.remove(pgpass_file)
if err:
  msg = "ERROR: Unable to Initialize PG. see logfile: " + logfile
  fatal_error(msg)

util.set_column('datadir', pgver, pg_data)
util.set_column('logdir', pgver, pg_log)

util.update_postgresql_conf(pgver, i_port)
pg_pass_file = util.remember_pgpassword(pg_password, str(i_port))
util.write_pgenv_file(pg_home, pgver, pg_data, 'postgres', 'postgres', str(i_port), pg_pass_file)

src_dir = pg_home + os.sep + "init" + os.sep
shutil.copy(src_dir + "pg_hba.conf", pg_data)

if isJson:
  sys.stdout = previous_stdout
  msg = '[{"status":"complete","msg":"Initialization completed.","component":"' + pgver + '"}]'
  print msg

if update_install_date:
  util.update_installed_date(pgver)
