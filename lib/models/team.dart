class Team {
  String teamID;
  String sport;
  String name;
  String abbrev;

  Team({
    required this.teamID,
    required this.sport,
    required this.name,
    required this.abbrev,
  });

  Team.empty([
    this.teamID = '',
    this.sport = '',
    this.name = '',
    this.abbrev = '',
  ]);

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamID: json['teamID'],
      sport: json['sport'],
      name: json['name'],
      abbrev: json['abbrev'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamID': teamID,
      'sport': sport,
      'name': name,
      'abbrev': abbrev,
    };
  }
}
