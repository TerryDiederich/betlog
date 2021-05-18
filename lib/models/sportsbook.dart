class Sportsbook {
  String sportsbookID;
  String name;
  int sortOrder;

  Sportsbook({
    required this.sportsbookID,
    required this.name,
    required this.sortOrder,
  });

  Sportsbook.empty([
    this.sportsbookID = '',
    this.name = '',
    this.sortOrder = 0,
  ]);

  factory Sportsbook.fromJson(Map<String, dynamic> json) {
    return Sportsbook(
      sportsbookID: json['sportsbookID'],
      name: json['name'],
      sortOrder: json['sortOrder'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sportsbookID': sportsbookID,
      'name': name,
      'sortOrder': sortOrder,
    };
  }
}
