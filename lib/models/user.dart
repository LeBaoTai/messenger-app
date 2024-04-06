
class UserModel {
  final String uuid;
  final String username;
  final String email;
  final List<String> friends;
  final List<String> pending;
  final List<String> requests;
  final List<String> currentChats;

  UserModel(
      {required this.uuid,
      required this.username,
      required this.email,
      required this.friends,
      required this.pending,
      required this.requests,
      required this.currentChats});

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'username': username,
      'email': email,
      'list_friends': friends,
      'pending': pending,
      'requests': requests,
      'current_chats': currentChats,
    };
  }

  static fromMap(Map map) {
    return UserModel(
      uuid: map['uuid'],
      username: map['username'],
      email: map['email'],
      friends: map['list_friends'],
      pending: map['pending'],
      requests: map['list_friends'],
      currentChats: map['current_chats'],
    );
  }
}
