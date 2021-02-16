// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:chat_app/Models/constants.dart';

class MessageBox extends StatelessWidget {
  final TextEditingController messageController;
  final room;
  const MessageBox({
    Key key,
    @required this.room,
    @required this.messageController,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: messageController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none
                ),
              ),
            ),
            SizedBox(width: 15,),
            FloatingActionButton(
              onPressed: sendMessage,
              child: Icon(Icons.send,color: Colors.white,size: 18,),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],
          
        ),
      ),
    );
  }
  sendMessage(){
    socket.emit('incoming-msg', {'username':window.sessionStorage['username'],'message':messageController.text,'room':room});
    messageController.text = '';
  }
}


