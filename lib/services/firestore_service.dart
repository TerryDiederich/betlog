import 'package:betlog/models/sport.dart';
import 'package:betlog/models/sportsbook.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//https://github.com/flutter/flutter/issues/27095

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  String colSports = 'sports';
  String colSportsbooks = 'sportsbooks';

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
}
