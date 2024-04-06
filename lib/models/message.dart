import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String senderId;
  final String senderName;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel({required this.senderId, required this.receiverId, required this.senderName, required this.message, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}