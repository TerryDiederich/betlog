class Sport {
  final int? id;
  final String name;
  final int? sortOrder;

  Sport({
    this.id,
    required this.name,
    required this.sortOrder,
  });

  Sport.fromMap(Map<String, dynamic> dto)
      : id = dto["id"],
        name = dto["name"],
        sortOrder = dto["sortOrder"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'sortOrder': sortOrder,
    };
  }
}
