import 'package:betlog/models/sport.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SportProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _sportID = '';
  String _name = '';
  int _sortOrder = 0;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  int get sortOrder => _sortOrder;
  Stream<List<Sport>> get sports => firestoreService.getSports();
  Future<List<Sport?>> get sportsList async =>
      await firestoreService.getSportsList();

  //setters
  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeSortOrder(int sortOrder) {
    _sortOrder = sortOrder;
    notifyListeners();
  }

  //functions
  initializeSport(Sport sport) {
    _name = sport.name;
    _sortOrder = sport.sortOrder;
    _sportID = sport.sportID;
  }

  initializeEmptySport() {
    _name = '';
    _sortOrder = 0;
    _sportID = '';
  }

  saveSport() {
    if (_sportID == '') {
      //add
      var newSport = Sport(
        name: _name,
        sortOrder: _sortOrder,
        sportID: uuid.v1(),
      );
      firestoreService.setSport(newSport);
    } else {
      //edit
      var updatedSport = Sport(
        name: _name,
        sortOrder: _sortOrder,
        sportID: _sportID,
      );
      firestoreService.setSport(updatedSport);
    }
  }

  remoteSport(String sportID) {
    firestoreService.removeSport(sportID);
  }
}
