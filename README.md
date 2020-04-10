# au
Cod 4 (quake c) custom command system for mods


### Add custom command plugin system to your mod
- extract files to **au/** directory inside root of mod  
```sh
     mods/
      ├── mymod/
      │   ├── au/
      │   │  ├── _cmd_handler.gsc
      │   │  ├── _cmd_def.gsc 
      │   │  ├── _utils.gsc
      │   │ 
      │   ├── maps/
      │   ├── mp/
      │   ├── ui/
```
- Add following line to init() function of ***maps/mp/gametypes/_globallogic.gsc***
```c
thread au\_cmd_handler::init();
```

### Creating new cmd.
Edit au/_cmd_handler.gsc
1. Add a function to handle the cmd (preferably at au\_cmd_def.gsc ).

    signature: 
        ***cmd_handler_function(player, cmd){...}***

        args:
            player: player entity
            cmd: array
                cmd[0]: cmd_name
                cmd[1]: player entity
                cmd[2 ... n]: optional arguments

2. registercmd in registerCMDS() using **cmd_handler_function** pointer. 
  ```cpp
  level.registered_cmd[cmd_name] = au\_cmd_def::cmd_handler_function;
  ```

### Usage
You can invoke the cmd by setting following two Dvars

* **cmdnum** : should be used with player slot id argument.
* **cmdnick** : should be used with player nickname argument.

General invocation format :
```sh
<cmd_name>:<player-id-or-name>:<optional-args-separated-by-colon>
```

1. Via rcon
- To kill player at slot id 0
```sh
/rcon set cmdnum kill:0
```
- To kill player using name (substr will also work)
```sh
/rcon set cmdnick kill:noobmaster69
```

2. Via B3
- Set in customcommands.ini
```ini
kill = set cmdnick kill:<PLAYER:NAME>
```



