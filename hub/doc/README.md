PGCLI is a PrettyGoodCommandLIne interface for component control and management.  

## Usage ##
```
#!
pgc [options] command [component1 [component2 ...] ]
```

## Informational Commands ##
```
#!
  help      - Display help file
  info      - Display OS or component information
  status    - Display status of installed server components 
  list      - Display available components 
               (use the update command to refresh the list of available components)

```

## Service Control Commands ##
```
#!
  start     - Start server components
  stop      - Stop server components
  reload    - Reload server configuration files (without a restart)
  restart   - Stop & the Start server components

  enable    - Enable a component
  disable   - Disable a server server component from starting automatically

  config    - Configure a component
  init      - Initialize a component.  For example
                 ./pgc init pg95 --options "-e utf"


```

## Software Install & Update Commands ##
```
#!
  update    - Retrieve new lists of components
  upgrade   - Perform an upgrade
  install   - Install (or re-install) a component  
  remove    - Remove component   
  download  - Download the component file into the cache directory
  clean     - Erase downloaded component files
```

## Experimental Commands ##
```
#!
  get        - Retrieve a Setting.  ie  get GLOBAL REPO
  set        - Populate a Setting.  ie  set GLOBAL REPO "http://localhost:8000"
  unset      - Remove a Setting (very dangerous if you dont know what you are doing) 
  register   - Create a remote HOST or PG connection
  unregister - Delete a remote HOST or PG connection
  --host     - Specify a remote HOST or PG connection for a PGC command
```