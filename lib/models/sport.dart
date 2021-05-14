class Sport {
  final String sportID;
  final String name;
  final int sortOrder;

  Sport({
    required this.sportID,
    required this.name,
    required this.sortOrder,
  });

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      name: json['name'],
      sortOrder: json['sortOrder'],
      sportID: json['sportID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sortOrder': sortOrder,
      'sportID': sportID,
    };
  }
}
