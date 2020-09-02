import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Key key;
  final bool isME;
  final String image;
  ChatBubble(this.message,this.isME,this.image,this.key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(image);
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isME ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: width*0.60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: isME ? Radius.circular(20) : Radius.circular(0),
                  bottomRight:  !isME ? Radius.circular(20) : Radius.circular(0),
                ),
                color: isME ? Colors.grey[300] : Theme.of(context).accentColor,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 8),
//              constraints: BoxConstraints(minWidth: 20,maxWidth: width*0.60),
              child: Text(message,style: TextStyle(fontSize:18,color: isME ? Theme.of(context).accentColor : Colors.white),textAlign: isME? TextAlign.end : TextAlign.start,),
            ),
          ],
        ),
        Positioned(child: CircleAvatar(backgroundImage: NetworkImage(image),),top: 0,left: !isME ? width*0.55 : null, right: !isME ? null : width*0.55,),
      ],
      overflow: Overflow.visible,
    );
  }
}
