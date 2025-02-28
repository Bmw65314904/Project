class ExchangeProgram {
  String id;
  String name;
  String university;
  String country;
  DateTime startDate;
  DateTime endDate;

  ExchangeProgram({
    required this.id,
    required this.name,
    required this.university,
    required this.country,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'university': university,
      'country': country,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory ExchangeProgram.fromMap(Map<String, dynamic> map) {
    return ExchangeProgram(
      id: map['id'],
      name: map['name'],
      university: map['university'],
      country: map['country'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }
}
