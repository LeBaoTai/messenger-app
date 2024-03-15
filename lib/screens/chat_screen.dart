import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/services/chat/chat_services.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatScreen(
      {super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messagesController = TextEditingController();

  final ChatService _chatService = ChatService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messagesController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messagesController.text);
      _messagesController.clear();
    }
  }

  Widget _buildChatMessageList() {
    return StreamBuilder(
      stream:
          _chatService.getMessage(widget.receiverId, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something wrong!!!');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Waiting...!!!');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildChatMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildChatMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: EdgeInsets.all(15),
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _messagesController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: 'Input',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _sendMessage,
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}
