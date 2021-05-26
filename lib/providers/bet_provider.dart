import 'package:betlog/models/bet.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class BetProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  //Getters
  Stream<List<Bet>> get bets => firestoreService.getBetsStream();
}
