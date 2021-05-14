import 'package:betlog/models/sport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//https://github.com/flutter/flutter/issues/27095

class Database {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Sport>> getSports() {
    return _db.collection('sports').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Sport.fromJson(doc.data())).toList());
  }

  // upsert
  Future<void> setSport(Sport sport) {
    var options = SetOptions(merge: true);
    return _db
        .collection('sports')
        .doc(sport.sportID)
        .set(sport.toMap(), options);
  }

  Future<void> removeSport(String sportID) {
    return _db.collection('sports').doc(sportID).delete();
  }
}
