import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _controller = TextEditingController();

  void _sendMsg() async
  {
    final auth = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(auth.uid).get();
    Firestore.instance.collection('chat').add({
      'text' : _controller.text.trim(),
      'createdOn' : Timestamp.now(),
      'userId': auth.uid,
      'userImage':userData['imgUrl'],
    });
    setState(() {
      _controller.clear();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TextField(decoration:  InputDecoration(labelText: 'Send a message...',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          controller: _controller,
          onChanged: (val){
            setState(() {

            });
          },)),
          IconButton(icon: Icon(Icons.send), onPressed: _controller.text.trim().length <= 0 ? null : _sendMsg)
        ],
      ),
    );
  }
}
