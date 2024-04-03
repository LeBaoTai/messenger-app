
class UserModel {
  final String uuid;
  final String username;
  final String email;
  final List<String> friends;

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
      'listFriends': friends,
    };
  }

  static fromMap(Map map) {
    return UserModel(
      uuid: map['uuid'],
      username: map['username'],
      email: map['email'],
      friends: map['listFriends'],
    );
  }
}
