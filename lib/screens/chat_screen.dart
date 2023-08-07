import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
User? loggedinuser;
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textcontrollor = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  //this User is firebaseuser whoes detial will be save in firebase
  // final bool currentUser = loggedinuser!.email as bool;
  String? messagetext;




  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() async {
    try {
      final user = await auth.currentUser!;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
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
                auth.signOut();
                Navigator.pop(context);
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('messages').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    try {
                      return ListView(
                        reverse: true,
                        children: snapshot.data!.docs.reversed
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        bottomLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),                                     
                                      )                                     
                                
                                    ),
                                    child: Text(data['text'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),
                                  ),
                              Text(data['sender'].toString(),style: TextStyle(color: Colors.grey[600],fontSize: 12),),
                                ],
                              ),
                          );
                          
                        }).toList(),
                      );
                    } catch (e) {
                      return Container(
                        child: Text('Error:'+ e.toString()),
                      );
                    }
                  }
                },
              ),
            ),
            Container(
              height: 60.0,
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textcontrollor,
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      textcontrollor.clear();
                      firestore.collection('messages').add({
                        'text': messagetext,
                        'sender': loggedinuser!.email,
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
