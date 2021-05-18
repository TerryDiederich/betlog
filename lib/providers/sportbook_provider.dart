import 'package:betlog/models/sportsbook.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SportsbookProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _sportsbookID = '';
  String _name = '';
  int _sortOrder = 0;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  int get sortOrder => _sortOrder;
  Stream<List<Sportsbook>> get sportsbooks =>
      firestoreService.getSportsbooksStream();
  Future<List<Sportsbook?>> get sportsbooksList async =>
      await firestoreService.getSportsbookList();

  //Setters
  set changeName(String name) {
    _name = name;
    notifyListeners();
  }

  set changeSortOrder(int sortOrder) {
    _sortOrder = sortOrder;
    notifyListeners();
  }

  //Functions
  initializeSportsbook(Sportsbook sportsbook) {
    _sportsbookID = sportsbook.sportsbookID;
    _name = sportsbook.sportsbookID;
    _sortOrder = sportsbook.sortOrder;
  }

  initializeEmptySportsbook() {
    _sportsbookID = '';
    _name = '';
    _sortOrder = 0;
  }

  saveSportsbook() {
    if (_sportsbookID == '') {
      //add
      var newSportsbook = Sportsbook(
        sportsbookID: uuid.v1(),
        name: _name,
        sortOrder: _sortOrder,
      );
      firestoreService.setSportsbook(newSportsbook);
    } else {
      //update
      var updatedSportsbook = Sportsbook(
        sportsbookID: _sportsbookID,
        name: _name,
        sortOrder: _sortOrder,
      );
      firestoreService.setSportsbook(updatedSportsbook);
    }
  }

  removeSportsbook(String sportsbookID) {
    firestoreService.removeSportsbook(sportsbookID);
  }
}
