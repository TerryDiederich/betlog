import 'package:betlog/models/sport.dart';
import 'package:betlog/models/sportsbook.dart';
import 'package:betlog/models/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//https://github.com/flutter/flutter/issues/27095

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  String colSports = 'sports';
  String colSportsbooks = 'sportsbooks';
  String colTeams = 'teams';

  // ---------- Sports----------------------------------------------
  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots() {
    return _db.collection(colSports).snapshots();
  }

  Stream<List<Sport>> getSportsStream() {
    return _db.collection(colSports).orderBy('sortOrder').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Sport.fromJson(doc.data())).toList());
  }

  Future<List<Sport?>> getSportsList() async {
    QuerySnapshot querySnapshot =
        await _db.collection(colSports).orderBy('sortOrder').get();

    final sports = querySnapshot.docs
        .map((doc) => Sport(
              name: doc['name'],
              sortOrder: doc['sortOrder'],
              sportID: doc['sportID'],
            ))
        .toList();

    return sports;
  }

  Future<Sport?> getOneSport(String name) async {
    QuerySnapshot querySnapshot =
        await _db.collection(colSports).where('name', isEqualTo: name).get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    } else {
      final sport = querySnapshot.docs
          .map((doc) => Sport(
                name: doc['name'],
                sortOrder: doc['sortOrder'],
                sportID: doc['sportID'],
              ))
          .first;
      return sport;
    }
  }

  // upsert
  Future<void> setSport(Sport sport) async {
    Sport? workSport = await getOneSport(sport.name);

    if (workSport != null) {
      sport.sportID = workSport.sportID;
    }

    var options = SetOptions(merge: true);
    return _db
        .collection(colSports)
        .doc(sport.sportID)
        .set(sport.toMap(), options);
  }

  Future<void> removeSport(String sportID) {
    return _db.collection(colSports).doc(sportID).delete();
  }
  // ---------- Sports----------------------------------------------

  // ---------- Sportsbooks----------------------------------------------
  Stream<List<Sportsbook>> getSportsbooksStream() {
    return _db.collection(colSportsbooks).orderBy('sortOrder').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Sportsbook.fromJson(doc.data()))
            .toList());
  }

  Future<List<Sportsbook?>> getSportsbookList() async {
    QuerySnapshot querySnapshot =
        await _db.collection(colSportsbooks).orderBy('sortOrder').get();

    final sportsbooks = querySnapshot.docs
        .map((doc) => Sportsbook(
              name: doc['name'],
              sortOrder: doc['sortOrder'],
              sportsbookID: doc['sportsbookID'],
            ))
        .toList();

    return sportsbooks;
  }

  Future<Sportsbook?> getOneSportsbook(String name) async {
    QuerySnapshot querySnapshot = await _db
        .collection(colSportsbooks)
        .where('name', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    } else {
      final sportsbook = querySnapshot.docs
          .map((doc) => Sportsbook(
                name: doc['name'],
                sortOrder: doc['sortOrder'],
                sportsbookID: doc['sportsbookID'],
              ))
          .first;
      return sportsbook;
    }
  }

  // upsert
  Future<void> setSportsbook(Sportsbook sportsbook) async {
    Sportsbook? workSportsbook = await getOneSportsbook(sportsbook.name);

    if (workSportsbook != null) {
      sportsbook.sportsbookID = workSportsbook.sportsbookID;
    }

    var options = SetOptions(merge: true);
    return _db
        .collection(colSportsbooks)
        .doc(sportsbook.sportsbookID)
        .set(sportsbook.toMap(), options);
  }

  Future<void> removeSportsbook(String sportsbookID) {
    return _db.collection(colSportsbooks).doc(sportsbookID).delete();
  }

  // ---------- Sportsbooks----------------------------------------------

  // ---------- Teams----------------------------------------------
  Stream<List<Team>> getTeamsForSportByNameStream(String _sport) {
    return _db
        .collection(colTeams)
        .orderBy('name')
        .where('sport', isEqualTo: _sport)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Team.fromJson(doc.data())).toList());
  }

  Future<List<Team?>> getTeamsByNameList() async {
    QuerySnapshot querySnapshot =
        await _db.collection(colTeams).orderBy('name').get();

    final teams = querySnapshot.docs
        .map((doc) => Team(
              teamID: doc['teamid'],
              sport: doc['sport'],
              name: doc['name'],
              abbrev: doc['abbrev'],
            ))
        .toList();

    return teams;
  }

  Future<Team?> getOneTeamByName(String name) async {
    QuerySnapshot querySnapshot =
        await _db.collection(colTeams).where('name', isEqualTo: name).get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    } else {
      final team = querySnapshot.docs
          .map((doc) => Team(
                teamID: doc['teamid'],
                sport: doc['sport'],
                name: doc['name'],
                abbrev: doc['abbrev'],
              ))
          .first;
      return team;
    }
  }

  // upsert
  Future<void> setTeam(Team team) async {
    Team? workTeam = await getOneTeamByName(team.name);

    if (workTeam != null) {
      team.teamID = workTeam.teamID;
    }

    var options = SetOptions(merge: true);
    return _db.collection(colTeams).doc(team.teamID).set(team.toMap(), options);
  }

  Future<void> removeTeam(String teamID) {
    return _db.collection(colTeams).doc(teamID).delete();
  }
  // ---------- Teams----------------------------------------------
}
