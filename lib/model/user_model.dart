class kUser{
  final String uid;
  final String name;
  final String email;
  final String status_massage;
  final List takedClass;
  final List myClass;
  final List likedClass;
  kUser({
    required this.uid,
    required this.takedClass,
    required this.myClass,
    required this.name,
    required this.email,
    required this.status_massage,
    required this.likedClass,
  });
  kUser.fromMap(Map<String, dynamic> map)
      : uid = map["uid"].toString(),
        name = map["name"].toString(),
        email = map["email"].toString(),
        status_massage = map["status_massage"].toString(),
        takedClass = map["takedClass"],
        myClass = map["myClass"],
        likedClass = map["likedClass"];
}