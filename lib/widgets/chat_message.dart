import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locally_chat/widgets/chat_bubble.dart';

class ChatMessage extends StatefulWidget {
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: Firestore.instance
                      .collection('chat')
                      .orderBy('createdOn', descending: true)
                      .snapshots(),
                  builder: (context, streamSnap) {
                    if (streamSnap.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    final docs = streamSnap.data.documents;
                    return ListView.builder(
                        reverse: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) => ChatBubble(
                            docs[index]['text'],
                            docs[index]['userId'] == snapshot.data.uid,
                            docs[index]['userImage'],
                            ValueKey(docs[index].documentID)));
                  }),
    );
  }
}
