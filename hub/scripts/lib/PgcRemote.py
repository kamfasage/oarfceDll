####################################################################
############      Copyright (c) 2016 BigSQL           ##############
####################################################################

import paramiko


class PgcRemoteException(Exception):
    pass


class PgcRemote(object):
    def __init__(self, host, user, password):
        self.user = user
        self.host = host
        self.password = password
        self.sftp = None
        self.client = None

    def connect(self):
        pgc_remote_ssh = paramiko.SSHClient()
        pgc_remote_ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        pgc_remote_ssh.connect(self.host,
                               username=self.user,
                               password=self.password,
                               timeout=10)
        self.client = pgc_remote_ssh

    def is_exists(self, path):
        try:
            self.sftp = paramiko.SFTPClient.from_transport(self.client.get_transport())
            self.sftp.stat(path)
        except IOError, e:
            if e[0] == 2:
                return False
            raise
        else:
            return True

    def upload(self, remote_path):
        stdin, stdout, stderr = self.client.exec_command(
            "cd " + remote_path + '; python -c "$(curl -fsSL http://s3.amazonaws.com/pgcentral/install.py)"')
        for line in stdout.readlines():
            print line.rstrip('\n')

        rc = 0
        for line in stderr.readlines():
            rc = 1
            print line.rstrip('\n')

    def disconnect(self):
        self.client.close()
