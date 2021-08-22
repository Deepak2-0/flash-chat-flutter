import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String url = "/chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  final _fireStore = FirebaseFirestore.instance;
  String textMessage;

  @override
  void initState() {
    super.initState();
    loggedInUser = _auth.currentUser;
    //print('####loggedInUser $loggedInUser @@@@@@ ${loggedInUser.email}');
    //getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Something went wrong, Please try again later");
                } else {
                  final messages = snapshot.data.docs;

                  List<Text> messageWidget = [];
                  for (var message in messages) {
                    String sender = message.get('sender');
                    String textMessage = message.get('textMessage');
                    //print('##### ${message.data()}');
                    messageWidget.add(
                      Text(
                        '$textMessage from $sender',
                        style: TextStyle(fontSize: 50),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView(
                      children: messageWidget,
                    ),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _fireStore.collection("messages").add({
                        "sender": loggedInUser.email,
                        "textMessage": textMessage,
                      });
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

class MessageUser {
  String sender;
  String textMessages;

  MessageUser(this.sender, this.textMessages);
}
