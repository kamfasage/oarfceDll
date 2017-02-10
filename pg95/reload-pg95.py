
####################################################################
#########            Copyright 2016 BigSQL               ###########
####################################################################

import os, sys, util

pgver = "pg95"

PGC_HOME = os.getenv('PGC_HOME', '')

homedir = os.path.join(PGC_HOME, pgver)


datadir = util.get_column('datadir', pgver)

pg_ctl = os.path.join(homedir, "bin", "pg_ctl")
parms = ' reload -D "' + datadir + '"'

print 'pg_ctl' + parms
rc = util.system(pg_ctl + parms)
sys.exit(rc)
