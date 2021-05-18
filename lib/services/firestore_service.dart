import 'package:betlog/models/sport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//https://github.com/flutter/flutter/issues/27095

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Sport>> getSports() {
    return _db.collection('sports').orderBy('sortOrder').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Sport.fromJson(doc.data())).toList());
  }

  Future<List<Sport?>> getSportsList() async {
    QuerySnapshot querySnapshot =
        await _db.collection('sports').orderBy('sortOrder').get();

    final allData = querySnapshot.docs
        .map((doc) => Sport(
              name: doc['name'],
              sortOrder: doc['sortOrder'],
              sportID: doc['sportID'],
            ))
        .toList();

    return allData;
  }

  Future<Sport?> getOneSport(String name) async {
    QuerySnapshot querySnapshot =
        await _db.collection('sports').where('name', isEqualTo: name).get();

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
        .collection('sports')
        .doc(sport.sportID)
        .set(sport.toMap(), options);
  }

  Future<void> removeSport(String sportID) {
    return _db.collection('sports').doc(sportID).delete();
  }
}
