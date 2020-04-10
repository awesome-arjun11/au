getPlayerByNum(id){
    allPlayers = getEntArray( "player", "classname" );
    for(i = 0; i < allPlayers.size; i++)
        if(allPlayers[i] getEntityNumber() == id)
            return allPlayers[i];
}

getPlayerByName(name){
    allPlayers = getEntArray( "player", "classname" );
    for(i = 0; i < allPlayers.size; i++)
        if ( isSubStr( toLower(allPlayers[i].name), toLower(name) ) )
            return allPlayers[i];
}

getPlayer(identifier){
    if(isString(identifier))
        return getPlayerByName(identifier);
    else
        return getPlayerByNum(identifier);
}


isReallyAlive(){
	return self.sessionstate == "playing";
}

isPlaying(){
	return isReallyAlive();
}


playSoundOnAllPlayers( soundAlias ){
	allPlayers = getEntArray( "player", "classname" );
	for( i = 0; i < allPlayers.size; i++ )
        allPlayers[i] playLocalSound( soundAlias );
}

deleteAfterTime( time ){
	wait time;
	if( isDefined( self ) )
		self delete();
}


cleanName( string ) {
	string = tolower(string);
	output = "";
	for( i = 0; i < string.size; i++ ){
		if(string[i] == " " || string == "*" || string == "." || string == "[" || string == "]" || string == "/" ) {
			i++;
			continue;
		}
		if(string[i] == "^") {
			if(i < string.size - 1) {
				if ( string[i + 1] == "0" || string[i + 1] == "1" || string[i + 1] == "2" || string[i + 1] == "3" || string[i + 1] == "4" ||
					 string[i + 1] == "5" || string[i + 1] == "6" || string[i + 1] == "7" || string[i + 1] == "8" || string[i + 1] == "9" ) {
					i++;
					continue;
				}
			}
		}
		output += string[i];
	}
	return output;
}