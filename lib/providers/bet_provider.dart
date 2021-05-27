import 'package:betlog/models/bet.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class BetProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _betID = '';
  String _sportsbook = '';
  String _sport = '';
  int _gamedate = 0;
  String _betType = '';
  String _betTeam = '';
  int _odds = 0;
  double _spread = 0;
  double _total = 0;
  String _overunder = '';
  String _notes = '';
  double _amountBet = 0;
  double _amountToWin = 0;
  String _awayTeam = '';
  int _awayTeamScore = 0;
  String _homeTeam = '';
  int _homeTeamScore = 0;
  String _didWin = '';
  String _didCover = '';
  var uuid = Uuid();

  //Getters
  Stream<List<Bet>> get bets => firestoreService.getBetsStream();

  Future<void> saveLocal() async {
    _betID = '';
    _sportsbook = 'Draftkings';
    _sport = 'NFL';
    _gamedate = DateTime(2021, 5, 29, 13, 30).millisecondsSinceEpoch;
    _betType = 'Totals';
    _betTeam = '';
    _odds = -110;
    _spread = 0;
    _total = 54.5;
    _overunder = 'Over';
    _notes = '';
    _amountBet = 110;
    _amountToWin = 100;
    _awayTeam = 'BAL';
    _awayTeamScore = 0;
    _homeTeam = 'KC';
    _homeTeamScore = 0;
    _didWin = '';
    _didCover = '';
    await saveBet();
  }

  saveBet() async {
    if (_betID == '') {
      //add
      var newBet = Bet(
        betID: uuid.v1(),
        sportsbook: _sportsbook,
        sport: _sport,
        gamedate: _gamedate,
        betType: _betType,
        betTeam: _betTeam,
        odds: _odds,
        spread: _spread,
        total: _total,
        overunder: _overunder,
        notes: _notes,
        amountBet: _amountBet,
        amountToWin: _amountToWin,
        awayTeam: _awayTeam,
        awayTeamScore: _awayTeamScore,
        homeTeam: _homeTeam,
        homeTeamScore: _homeTeamScore,
        didWin: _didWin,
        didCover: _didCover,
      );
      await firestoreService.setBet(newBet);
    } else {
      //update
      var updatedBet = Bet(
        betID: _betID,
        sportsbook: _sportsbook,
        sport: _sport,
        gamedate: _gamedate,
        betType: _betType,
        betTeam: _betTeam,
        odds: _odds,
        spread: _spread,
        total: _total,
        overunder: _overunder,
        notes: _notes,
        amountBet: _amountBet,
        amountToWin: _amountToWin,
        awayTeam: _awayTeam,
        awayTeamScore: _awayTeamScore,
        homeTeam: _homeTeam,
        homeTeamScore: _homeTeamScore,
        didWin: _didWin,
        didCover: _didCover,
      );
      await firestoreService.setBet(updatedBet);
    }
  }
}
