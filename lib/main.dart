import 'package:flutter/material.dart';
import 'package:locally_chat/screens/auth_screen.dart';
import 'package:locally_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.deepPurpleAccent,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary
        ),
        backgroundColor: Colors.pink
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(builder: (ctx,snapshot){
        if(snapshot.hasData)
          {
            return  ChatScreen();
          }
        return AuthScreen();
      },stream: FirebaseAuth.instance.onAuthStateChanged,),
    );
  }
}

