class Assignment {
  String? id;
  final String date;
  final String name;
  final List complete;

  Assignment({
    required this.id,
    required this.date,
    required this.name,
    required this.complete,
  });

  Assignment.fromMap(Map<String, dynamic> map)
      : date = map["date"].toString(),
        name = map["name"].toString(),
        complete = map["complete"];
}