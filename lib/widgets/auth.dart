import 'package:flutter/material.dart';
import 'dart:io';
import 'package:locally_chat/widgets/user_image_picker.dart';

class Auth extends StatefulWidget {
  final Function( String email, File image, String userName, String password, bool isLogin,BuildContext ctx) submitData;
  final isLoading;
  Auth(this.submitData,this.isLoading);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final formKey = GlobalKey<FormState>();
  String email='',userName='',pwd='';
  File _userImage;
  var isLogin = true;
  void login()
  {
    if(!formKey.currentState.validate())
      {
        return;
      }
    if(_userImage == null && !isLogin)
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Image needs to be picked !'),backgroundColor: Colors.black54,));
        return;
      }
    FocusScope.of(context).unfocus();
    formKey.currentState.save();
    print(email);
    print(userName);
    print(pwd);
    widget.submitData(email.trim(),_userImage,userName.trim(),pwd.trim(),isLogin,context);
  }
  void _pickedImage(File image)
  {
    _userImage = image;
  }
  @override
  Widget build(BuildContext context) {
    print('building authscreen');
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    validator: (value){
                      if(value.isEmpty)
                        {
                          return 'Email address field is empty';
                        }
                     else if(!value.contains('@'))
                        {
                          return 'Enter valid Email address';
                        }
                     return null;
                    },
                    onSaved: (value){
                      email = value;
                    },
                  ),
                  if(!isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Username field is empty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      userName = value;
                    },
                  ),
                  TextFormField(
                  key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value){
                      if(value.isEmpty)
                      {
                        return 'Password field is empty';
                      }
                      else if(value.length<7)
                        {
                          return 'Password must have minimum of 8 characters';
                        }
                      return null;
                    },
                    onSaved: (value){
                      pwd = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  widget.isLoading ? CircularProgressIndicator() :
                  RaisedButton(
                    onPressed: () {login();},
                    child: Text(isLogin? 'Login' : 'Sign up'),
                  ),
                  widget.isLoading ? Container() :
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin?
                        'Create an account' : 'Already have an account',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
