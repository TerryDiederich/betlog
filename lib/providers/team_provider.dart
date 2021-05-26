import 'package:betlog/models/team.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TeamProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _teamID = '';
  String _sport = '';
  String _name = '';
  String _abbrev = '';
  var uuid = Uuid();

  //Getters
  String get name => _name;
  String get abbrev => _abbrev;
  Stream<List<Team>> get teams =>
      firestoreService.getTeamsForSportByNameStream('MLB');
  Future<List<Team?>> get getTeamsByNameList async =>
      await firestoreService.getTeamsByNameList('MLB');

  //setters
  set changeSport(String sport) {
    _sport = sport;
    notifyListeners();
  }

  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeAbbrev(String abbrev) {
    _abbrev = abbrev;
    notifyListeners();
  }

  //functions
  Stream<List<Team>> getTeams(String _sport) {
    return firestoreService.getTeamsForSportByNameStream(_sport);
  }

  Future<List<Team?>> getTeamsList(String _sport) {
    return firestoreService.getTeamsByNameList(_sport);
  }

  initializeTeam(Team team) {
    _teamID = team.teamID;
    _sport = team.sport;
    _name = team.name;
    _abbrev = team.abbrev;
  }

  initializeEmptyTeam() {
    _teamID = '';
    _sport = '';
    _name = '';
    _abbrev = '';
  }

  saveTeam() async {
    if (_teamID == '') {
      //add
      var newTeam = Team(
        teamID: uuid.v1(),
        sport: _sport,
        name: _name,
        abbrev: _abbrev,
      );
      await firestoreService.setTeam(newTeam);
    } else {
      //edit
      var updatedTeam = Team(
        teamID: _teamID,
        sport: _sport,
        name: _name,
        abbrev: _abbrev,
      );
      await firestoreService.setTeam(updatedTeam);
    }
  }

  removeTeam(String teamID) async {
    return await firestoreService.removeTeam(teamID);
  }

  removeAllTeams() async {
    return await firestoreService.removeAllTeams();
  }

  repopulate() async {
    await repopluateMLB();
    await repopulateNFL();
    await repopulateNHL();
  }

  repopluateMLB() async {
    String sport = 'MLB';

    this._teamID = '';
    this._sport = sport;
    this._name = 'Arizona Diamondbacks';
    this._abbrev = 'ARI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Atlanta Braves';
    this._abbrev = 'Atl';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Baltimore Orioles';
    this._abbrev = 'BAL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Boston Red Sox';
    this._abbrev = 'BOS';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Chicago White Sox';
    this._abbrev = 'CHW';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Chicago Cubs';
    this._abbrev = 'CHC';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Cincinnati Reds';
    this._abbrev = 'CIN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Cleveland Indians';
    this._abbrev = 'CLE';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Colorado Rockies';
    this._abbrev = 'COL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Detroit Tigers';
    this._abbrev = 'DET';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Florida Marlins';
    this._abbrev = 'FLA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Houston Astros';
    this._abbrev = 'HOU';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Kansas City Royals';
    this._abbrev = 'KAN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Los Angeles Angels';
    this._abbrev = 'LAA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Los Angeles Dodgers';
    this._abbrev = 'LAD';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Milwaukee Brewers';
    this._abbrev = 'MIL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Minnesota Twins';
    this._abbrev = 'MIN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Mets';
    this._abbrev = 'NYM';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Yankees';
    this._abbrev = 'NYY';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Oakland Athletics';
    this._abbrev = 'OAK';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Philadelphia Phillies';
    this._abbrev = 'PHI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Pittsburgh Pirates';
    this._abbrev = 'PIT';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'San Diego Padres';
    this._abbrev = 'SD';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'San Francisco Giants';
    this._abbrev = 'SF';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Seattle Mariners';
    this._abbrev = 'SEA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'St Louis Cardinals';
    this._abbrev = 'STL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Tampa Bay Rays';
    this._abbrev = 'TB';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Texas Rangers';
    this._abbrev = 'TEX';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Toronto Blue Jays';
    this._abbrev = 'TOR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Washington Nationals';
    this._abbrev = 'WAS';
    saveTeam();
  }

  repopulateNFL() async {
    String sport = 'NFL';

    this._teamID = '';
    this._sport = sport;
    this._name = 'Arizona Cardinals';
    this._abbrev = 'ARI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Atlanta Falcons';
    this._abbrev = 'ATL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Baltimore Ravens';
    this._abbrev = 'BAL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Buffalo Bills';
    this._abbrev = 'BUF';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Carolina Panthers';
    this._abbrev = 'CAR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Chicago Bears';
    this._abbrev = 'CHI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Cincinnati Bengals';
    this._abbrev = 'CIN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Cleveland Browns';
    this._abbrev = 'CLE';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Dallas Cowboys';
    this._abbrev = 'DAL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Detroit Lions';
    this._abbrev = 'DET';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Green Bay Packers';
    this._abbrev = 'GB';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Houston Texans';
    this._abbrev = 'HOU';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Indianapolis Colts';
    this._abbrev = 'IND';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Jacksonville Jaguars';
    this._abbrev = 'JAX';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Kansas City Chiefs';
    this._abbrev = 'KS';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Miami Dolphins';
    this._abbrev = 'MIA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Minnesota Vikings';
    this._abbrev = 'MIN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New England Patriots';
    this._abbrev = 'NE';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New Orleans Saints';
    this._abbrev = 'NO';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Giants';
    this._abbrev = 'NYG';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Jets';
    this._abbrev = 'NYJ';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Las Vegas Raiders';
    this._abbrev = 'LV';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Philadelphia Eagles';
    this._abbrev = 'PHI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Pittsburgh Steelers';
    this._abbrev = 'PIT';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Los Angeles Chargers';
    this._abbrev = 'LAC';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'San Francisco 49ers';
    this._abbrev = 'SF';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Seattle Seahawks';
    this._abbrev = 'SEA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Los Angeles Rams';
    this._abbrev = 'LAR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Tampa Bay Buccaneers';
    this._abbrev = 'TB';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Tennessee Titans';
    this._abbrev = 'Ten';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Washington Football Team';
    this._abbrev = 'WFT';
    saveTeam();
  }

  repopulateNHL() async {
    String sport = 'NHL';

    this._teamID = '';
    this._sport = sport;
    this._name = 'Anaheim Ducks';
    this._abbrev = 'ANA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Arizona Coyotes';
    this._abbrev = 'ARI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Boston Bruins';
    this._abbrev = 'BOS';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Buffalo Sabres';
    this._abbrev = 'BUF';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Calgary Flames';
    this._abbrev = 'CCY';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Carolina Hurricanes';
    this._abbrev = 'CAR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Chicago Blackhawks';
    this._abbrev = 'CHI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Colorado Avalanche';
    this._abbrev = 'COL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Columbus Blue Jackets';
    this._abbrev = 'CBJ';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Dallas Stars';
    this._abbrev = 'DAL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Detroit Red Wings';
    this._abbrev = 'DET';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Edmonton Oilers';
    this._abbrev = 'EDM';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Florida Panthers';
    this._abbrev = 'FLA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Los Angeles Kings';
    this._abbrev = 'LA';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Minnesota Wild';
    this._abbrev = 'MIN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Montreal Canadiens';
    this._abbrev = 'MTL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Nashville Predators';
    this._abbrev = 'NSH';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New Jersey Devils';
    this._abbrev = 'NJ';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Islanders';
    this._abbrev = 'NYI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'New York Rangers';
    this._abbrev = 'NYR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Ottawa Senators';
    this._abbrev = 'OTT';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Phiadelphia Flyers';
    this._abbrev = 'PHI';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Pittsburgh Penguins';
    this._abbrev = 'PITT';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'San Jose Sharks';
    this._abbrev = 'SJ';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'St Louis Blues';
    this._abbrev = 'STL';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Tampa Bay Lightning';
    this._abbrev = 'TB';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Toronto Maple Leafs';
    this._abbrev = 'TOR';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Vancouver Canucks';
    this._abbrev = 'VAN';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Vegas Golden Knights';
    this._abbrev = 'VGK';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Washington Capitals';
    this._abbrev = 'WAS';
    saveTeam();

    this._teamID = '';
    this._sport = sport;
    this._name = 'Winnipeg Jets';
    this._abbrev = 'WIN';
    saveTeam();
  }
}
