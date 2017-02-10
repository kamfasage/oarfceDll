@ECHO OFF
REM start BAM2 service if not running
sc query "bigsql.bam2" | findstr "RUNNING"
IF NOT %errorlevel%==0 (
  sc start bigsql.bam2>nul
  PING -n 2 127.0.0.1>nul
)

REM wait (up to 10 seconds) for BAM2 to start
FOR /L %%A in (1, 1, 10) DO (
  sc query "bigsql.bam2" | findstr "RUNNING"
  IF %errorlevel%==0 (
    @REM service is running
    GOTO :RUNNING
  )
  PING -n 2 127.0.0.1>nul
)

:RUNNING
start http://localhost:8050

EXIT
