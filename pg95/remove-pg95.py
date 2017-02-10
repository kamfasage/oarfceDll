
####################################################################
#########            Copyright 2016 BigSQL               ###########
####################################################################

import os, util

pgver = "pg95"
dotver = pgver[2] + "." + pgver[3]

PGC_HOME = os.getenv('PGC_HOME', '')

autostart = util.get_column('autostart', pgver)
svcname   = util.get_column('svcname', pgver, 'PostgreSQL ' + dotver + ' Server')

if util.get_platform() == "Windows":
  if autostart == "on":
    sc_path = os.getenv("SYSTEMROOT", "") + os.sep + "System32" + os.sep + "sc"
    command = sc_path + ' delete "' + svcname + '"'
    util.system(command, is_admin=True)
else:
  pass
