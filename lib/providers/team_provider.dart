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

  saveTeam() {
    if (_teamID == '') {
      //add
      var newTeam = Team(
        teamID: uuid.v1(),
        sport: _sport,
        name: _name,
        abbrev: _abbrev,
      );
      firestoreService.setTeam(newTeam);
    } else {
      //edit
      var updatedTeam = Team(
        teamID: _teamID,
        sport: _sport,
        name: _name,
        abbrev: _abbrev,
      );
      firestoreService.setTeam(updatedTeam);
    }
  }

  removeTeam(String teamID) {
    firestoreService.removeTeam(teamID);
  }
}
