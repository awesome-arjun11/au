/// Playing Sounds eg
whyami(player, cmd){
  if(isPlayer(player)){
		player playSound("whyami");
	}
}


//  killing player
kill(player, cmd){
    if( isPlayer( player ) && player au\_utils::isReallyAlive() ){		
		player suicide();
		player iPrintlnBold( "^3You were killed by the Admin" );
	}
}


// taking ss
getss(player, cmd){
    if( !isDefined( cmd[2] ) ) // 3rd arg of caller
		return;
    if( isPlayer( player ) ){
        ssTakerPID = int(cmd[2]);
        guid = player getGuid();
        name = au\_utils::cleanName( player.name );
        result = execex( "getss " + player + " " + name + "_" + guid + "_" );
        exec("tell " + ssTakerPID + " ^0 => " + result );
    }
}

// switch user to spectator
spec(player, cmd){
  player thread maps\mp\gametypes\_globallogic::closeMenus();
	player [[level.spectator]]();
	wait 0.1;
	iPrintln( player.name + " was moved to spectator." );
}

// flash player
flash(player, cmd){
  if(player au\_utils::isReallyAlive())
    player thread maps\mp\_flashgrenades::applyFlash(6, 0.75);
}

// add yours below



