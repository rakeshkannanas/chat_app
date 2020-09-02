import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) userImage;
  UserImagePicker(this.userImage);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  bool isCam;
  final picker = ImagePicker();

  void pickImage() async {
    final image = await picker.getImage(
        imageQuality: 50,
        maxWidth: 150,
        source: isCam ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      _pickedImage = File(image.path);
    });
    widget.userImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        SizedBox(height: 10,),
        GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Pick Image'),
                      content: Text('How would you like to pick the image?'),
                      actions: [
                        FlatButton.icon(
                            icon: Icon(Icons.camera),
                            label: Text('Camera'),
                            onPressed: () {
                              setState(() {
                                isCam = true;
                              });
                              pickImage();
                              Navigator.of(context).pop();
                            }),
                        FlatButton.icon(
                            icon: Icon(Icons.image),
                            label: Text('Gallery'),
                            onPressed: () {
                              setState(() {
                                isCam = false;
                              });
                              pickImage();
                              Navigator.of(context).pop();
                            }),
                      ],
                    );
                  });
            },
            child: Text('Pick Image',style: TextStyle(color: Theme.of(context).primaryColor),)),
      ],
    );
  }
}
