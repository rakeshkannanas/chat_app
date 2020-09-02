import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally_chat/widgets/chat_message.dart';
import 'package:locally_chat/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         PopupMenuButton(
           itemBuilder: (_){
             return [
               PopupMenuItem(child: Text('Logout'), value: 'logout',)
             ];
           },
           onSelected: (val){
             if(val=='logout')
               {
                 FirebaseAuth.instance.signOut();
               }
           },
         )
        ],
        title: Text(
          'Local.ly',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(child: Column(children: [
        Expanded(child: ChatMessage()),
        NewMessage(),
      ],),),

    );
  }
}
