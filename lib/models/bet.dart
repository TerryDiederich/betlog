class Bet {
  String betID;
  String sportsbook;
  String sport;
  late DateTime gamedate;
  String betType;
  String betTeam;
  int odds;
  double spread;
  double total;
  String overunder;
  String notes;
  String awayTeam;
  int awayTeamScore;
  String homeTeam;
  int homeTeamScore;
  String didWin;
  String didCover;

  Bet({
    required this.betID,
    required this.sportsbook,
    required this.sport,
    required this.gamedate,
    required this.betType,
    required this.betTeam,
    required this.odds,
    required this.spread,
    required this.total,
    required this.overunder,
    required this.notes,
    required this.awayTeam,
    required this.awayTeamScore,
    required this.homeTeam,
    required this.homeTeamScore,
    required this.didWin,
    required this.didCover,
  });

  Bet.empty([
    this.betID = '',
    this.sportsbook = '',
    this.sport = '',
    this.betType = '',
    this.betTeam = '',
    this.odds = 0,
    this.spread = 0.0,
    this.total = 0.0,
    this.overunder = '',
    this.notes = '',
    this.awayTeam = '',
    this.awayTeamScore = 0,
    this.homeTeam = '',
    this.homeTeamScore = 0,
    this.didWin = '',
    this.didCover = '',
  ]);

  factory Bet.fromJson(Map<String, dynamic> json) {
    return Bet(
      betID: json['betID'],
      sportsbook: json['sportsbook'],
      sport: json['sport'],
      gamedate: json['gamedate'],
      betType: json['betType'],
      betTeam: json['betTeam'],
      odds: json['odds'],
      spread: json['spread'],
      total: json['total'],
      overunder: json['overunder'],
      notes: json['notes'],
      awayTeam: json['awayTeam'],
      awayTeamScore: json['awaTeamScore'],
      homeTeam: json['homeTeam'],
      homeTeamScore: json['homeTeamScore'],
      didWin: json['didWin'],
      didCover: json['didCover'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'betID': betID,
      'sportsbook': sportsbook,
      'sport': sport,
      'gamedate': gamedate,
      'betType': betType,
      'betTeam': betTeam,
      'odds': odds,
      'spread': spread,
      'total': total,
      'overunder': overunder,
      'notes': notes,
      'awayTeam': awayTeam,
      'awayTeamScore': awayTeamScore,
      'homeTeam': homeTeam,
      'homeTeamScore': homeTeamScore,
      'didWin': didWin,
      'didCover': didCover,
    };
  }
}
