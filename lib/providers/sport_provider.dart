import 'package:betlog/models/sport.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Stream<QuerySnapshot<Map<String, dynamic>>> get snapshots =>
      firestoreService.getSnapshots();
  Stream<List<Sport>> get sports => firestoreService.getSportsStream();
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

  saveSport() async {
    if (_sportID == '') {
      //add
      var newSport = Sport(
        name: _name,
        sortOrder: _sortOrder,
        sportID: uuid.v1(),
      );
      await firestoreService.setSport(newSport);
    } else {
      //edit
      var updatedSport = Sport(
        name: _name,
        sortOrder: _sortOrder,
        sportID: _sportID,
      );
      await firestoreService.setSport(updatedSport);
    }
  }

  removeSport(String sportID) {
    firestoreService.removeSport(sportID);
  }

  removeAllSports() async {
    await firestoreService.removeAllSports();
  }

  repopulate() async {
    this._sportID = '';
    this._name = 'MLB';
    this._sortOrder = 1;
    await saveSport();

    this._sportID = '';
    this._name = 'NFL';
    this._sortOrder = 2;
    await saveSport();

    this._sportID = '';
    this._name = 'NHL';
    this._sortOrder = 3;
    await saveSport();
  }
}
