String getBetLogCreateScript() {
  return 'CREATE TABLE betlog( ' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'gamedate INTEGER NOT NULL, ' +
      'sportsbookid INTEGER NOT NULL, ' +
      'sportid INTEGER NOT NULL, ' +
      'bettypeid INTEGER NOT NULL, ' +
      'awayteamid INTEGER NOT NULL, ' +
      'hometeamid INTEGER NOT NULL, ' +
      'betteamid INTEGER NOT NULL, ' +
      'awayteamscore INTEGER NOT NULL, ' +
      'hometeamscore INTEGER NOT NULL, ' +
      'odds NUMERIC NOT NULL, ' +
      'spread NUMERIC NOT NULL, ' +
      'total NUMERIC NOT NULL, ' +
      'overunder text NOT NULL, ' +
      'notes text NOT NULL, ' +
      'didwin text NOT NULL); ';
}

String getSportsBooksCreateScript() {
  return 'CREATE TABLE sportsbooks( ' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'description TEXT NOT NULL,  ' +
      'abbrev TEXT NOT NULL,  ' +
      'sortOrder INTEGER NOT NULL DEFAULT 0); ';
}

String getSportsCreateScript() {
  return 'CREATE TABLE sports( ' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'description TEXT NOT NULL,  ' +
      'sortOrder INTEGER NOT NULL DEFAULT 0); ';
}

String getTeamsCreateScript() {
  return 'CREATE TABLE teams( ' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'sportid INTEGER NOT NULL DEFAULT 0, ' +
      'description TEXT NOT NULL,  ' +
      'abbrev TEXT NOT NULL);  ';
}

String getBetTypesCreateScript() {
  return 'CREATE TABLE bettypes( ' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'description TEXT NOT NULL,  ' +
      'abbrev TEXT NOT NULL,  ' +
      'sortOrder INTEGER NOT NULL DEFAULT 0); ';
}
