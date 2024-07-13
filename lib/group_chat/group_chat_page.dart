import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caatsec/group_chat/chat_service.dart'; // تعديل المسار ليعكس موقع chat_service.dart

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _authFirebase = FirebaseAuth.instance;
  final ChatService _chatService = ChatService(); // تهيئة ChatService

  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authFirebase.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'Chat Room',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
        StreamBuilder<QuerySnapshot>(
        stream:
        _fireStore.collection("messages").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageData = message.data() as Map<String, dynamic>;
            final messageText = messageData['text'] as String?;
            final messageEmail = messageData['email'] as String?;

            if (messageText != null && messageEmail != null) {
              final currentUser = signedInUser.email;
              final messageWidget = MessageLine(
                email: messageEmail,
                text: messageText,
                isMe: currentUser == messageEmail,
              );
              messageWidgets.add(messageWidget);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        },
      ),
      Container(
      decoration: BoxDecoration(
      border: Border(
      top: BorderSide(
      color: Colors.blue,
      width: 2,
    ),
    ),
    ),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Expanded(
    child: TextField(
    controller: messageTextController,
    onChanged: (value) {
    messageText = value;
    },
    decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 20,
    ),
    hintText: 'Write your message here...',
    border: InputBorder.none,
    ),
    ),
    ),
      TextButton(
        onPressed: () {
          messageTextController.clear();
          _fireStore.collection("messages").add({
            "text": messageText,
            "email": signedInUser.email,
            "time": FieldValue.serverTimestamp(),
          });
          // إرسال الإشعار باستخدام خدمة ChatService
          _chatService.sendNotification(
              messageText!, signedInUser.uid);
        },
        child: Text(
          'send',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      )
    ],
    ),
      ),
            ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.email, this.text, required this.isMe});
  final String? email;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$email',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
                : BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}