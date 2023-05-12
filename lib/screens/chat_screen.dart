import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../widgets/message_bubble.dart';

final fireStore = FirebaseFirestore.instance;
late User loggedInUser;
final _auth = FirebaseAuth.instance;
final _controller = TextEditingController();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String messages;

  void getCurrentUser() async {
    var user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(fontSize: 17),
                      onChanged: (value) {
                        messages = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        fireStore.collection('messages').add({
                          'text': messages,
                          'sender': loggedInUser.email,
                          'time': Timestamp.now()
                        });
                      } catch (e) {
                        print(e);
                      }
                      _controller.clear();
                      messages = '';
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({
    super.key,
  });
  final fireStore = FirebaseFirestore.instance;
  late bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 300),
                CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ],
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        final List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {
            isCurrentUser = true;
          } else {
            isCurrentUser = false;
          }
          print(isCurrentUser);
          final mWidget = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: isCurrentUser,
          );
          messageWidgets.add(mWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.all(15.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
