#include au\_utils;

/* 
CMD general format: 

    CMDNAME:PLAYER_NAME:CALLER(optional):ARGS(optional)
or
    CMDNAME:PLAYER_SLOTID:CALLER(optional):ARGS(optional)


RCON USAGE: set cmdnum <cmd_name>:<playerPID>:<args delimmited by :>

B3 usage: set custom command
    cmd = set cmdnum cmd_name:<PLAYER:PID>:additionalargs
or
    cmd = set cmdnick cmd_name:<PLAYER:PID>:additionalargs


Command creation:

1. Add a function to handle the cmd (preferably at au\_cmd_def.gsc ).

    signature: 
        cmd_handler_function(player, cmd){...}

        args:
            player: player entity
            cmd: array
                cmd[0]: cmd_name
                cmd[1]: player entity
                cmd[2 ... n]: optional arguments

2. registercmd in registerCMDS() below. 
    level.registered_cmd[cmd_name] = au\_cmd_def::cmd_handler_function;

*/
info(p,c){
    iPrintlnBold("created by ^4root");
}


registerCMDS(){
    // level.registered_cmd["commandName"] = au\_cmd_def::functionName
    level.registered_cmd["info"] = ::info;
    level.registered_cmd["ss"] =  au\_cmd_def::getss; // rcon set cmdnick ss:playertotakessof:cmdcaller
    level.registered_cmd["kill"] =  au\_cmd_def::kill; // rcon set cmdnick kill:playertokill
    level.registered_cmd["whyami"] =  au\_cmd_def::whyami; // rcon set cmdnick whyami:caller
    level.registered_cmd["spectate"] =  au\_cmd_def::spec; // rcon set cmdnick spec:playertoswitchtospectator
    level.registered_cmd["flash"] =  au\_cmd_def::flash; // rcon set cmdnick flash:playertoflash with flashgranade
}




init(){
    makeDvarServerInfo( "cmdnum", "" );
    makeDvarServerInfo( "cmdnick", "" );
    registerCMDS();
    self endon("disconnect");
    for (;;){
		wait 0.15;

		cmd = strTok( getDvar("cmdnum"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) ){
            command = cmd[0];
            playerEntity = getplayer(int(cmd[1])); 
            if(isPlayer(playerEntity))
			    commandHandler( command, playerEntity, cmd );
			setDvar( "cmdnum", "" );
		}

		cmd = strTok( getDvar("cmdnick"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) ){
            command = cmd[0];
            playerEntity = getplayer(cmd[1]);
            if(isPlayer(playerEntity))
			    commandHandler( command, playerEntity, cmd );
			setDvar( "cmdnick", "" );
		}
	}
}


commandHandler(command, playerEntity, cmd){
    [[level.registered_cmd[command]]](playerEntity, cmd);
}










