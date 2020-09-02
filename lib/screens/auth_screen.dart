import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:locally_chat/widgets/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  var isLoading = false;
  AuthResult result;
  String url;
  void submitData(String email,File image,String userName,String password,bool isLogin,BuildContext ctx) async
  {
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else {
        result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(userName);
        final res = FirebaseStorage.instance.ref().child('image_path').child(result.user.uid+'.jpg');
        await res.putFile(image).onComplete;
        url = await res.getDownloadURL();
        Firestore.instance.collection('users').document(result.user.uid).setData({'username':userName,'email':email,'imgUrl':url,});
      }
    } on PlatformException
    catch(error)
    {
      setState(() {
        isLoading = false;
      });
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(error.message),backgroundColor: Colors.black54,));
    }
    catch(error)
    {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Auth(submitData,isLoading),
    );
  }
}
