import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/services/chat/chat_services.dart';

class ChatScreen extends StatefulWidget {
  final String receiverName;
  final String receiverId;
  const ChatScreen(
      {super.key, required this.receiverName, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messagesController = TextEditingController();

  final ChatService _chatService = ChatService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverName,
        ),
        backgroundColor: Colors.grey[300],
        elevation: 10,
        shadowColor: Colors.black,
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
          _chatService.getMessage(_auth.currentUser!.uid, widget.receiverId),
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

    return Row(
      mainAxisAlignment: data['senderId'] == _auth.currentUser!.uid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(15),
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: data['senderId'] == _auth.currentUser!.uid
                ? Colors.green
                : Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: data['senderId'] == _auth.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(data['senderName']),
              Text(
                data['message'],
                style: const TextStyle(
                  fontSize: 19,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          _renderSpace(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu_rounded,
                size: 30,
              )),
          Expanded(
            child: TextFormField(
              controller: _messagesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Input',
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: const Icon(
              Icons.send,
              size: 30,
            ),
          ),
          _renderSpace(),
        ],
      ),
    );
  }

  Widget _renderSpace() {
    return const SizedBox(
      width: 15,
    );
  }
}
