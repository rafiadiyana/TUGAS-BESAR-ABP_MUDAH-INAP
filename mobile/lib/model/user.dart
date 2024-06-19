import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone_number,
    this.avatarUrl,
  });

  String? id;
  String? name;
  String? email;
  String? password;
  String? phone_number;
  String? avatarUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone_number: json["phone_number"],
        avatarUrl: json["avatarUrl"],
      );

  User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        name = snapshot['name'],
        email = snapshot['email'],
        phone_number = snapshot['phone_number'],
        avatarUrl = snapshot['avatarUrl'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phone_number,
        "avatarUrl": avatarUrl,
      };
}
