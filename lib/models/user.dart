import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uuid;
  final String username;
  final String email;
  final List<User> friends;

  UserModel(
      {required this.uuid,
      required this.username,
      required this.email,
      required this.friends});

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
      'listFriend': friends,
    };
  }

  static fromMap(Map map) {
    return UserModel(
      uuid: map['uuid'],
      username: map['username'],
      email: map['email'],
      friends: map['friend']
    );
  }
}
