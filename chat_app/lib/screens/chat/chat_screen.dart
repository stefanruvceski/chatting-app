// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:async';
import 'package:chat_app/Models/chat_message.dart';
import 'package:chat_app/Models/constants.dart';
import 'package:chat_app/screens/chat/message_box.dart';
import 'package:chat_app/screens/chat/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  ChatScreen({Key key,this.index}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  List<ChatMessage> messages = [];
  final TextEditingController messageController = TextEditingController();
  
@override
void initState() { 
  super.initState();
  initSocket();
}
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      leading: 
      TextButton(onPressed:()=>backToHome(),
      child: Icon(Icons.arrow_back,)),
      title:Text(topics[widget.index],textAlign: TextAlign.center)),
      body:
        Stack(
          children: <Widget>[
            MessagesList(messages: messages,controller: controller,),
            MessageBox(messageController: messageController,room: topics[widget.index]),
          ]
        ),
    );
  }
  backToHome(){
  {
    socket.emit('leave',{'username':window.sessionStorage['username'],'room':topics[widget.index]});
    Navigator.pop(context);}
  }

  initSocket(){
    socket.on('message', (data) =>{
      if(data is List)
      {
        if(messages.isEmpty){
          for(final d in data){
            if (mounted) { 
              setState((){
                messages.add(ChatMessage(d['username'],d['message'],d['datetime']));
              })
            }
          }
        }
      }
      else{
        if (mounted) { 
          setState(() {
            messages.add(ChatMessage(data['username'],data['message'],data['datetime']));
          }),
        }
      },
      if (mounted) {  
        if(controller.hasClients){
          Timer(Duration(milliseconds: 2000), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn
            );
          })
        }
      }
    }); 
  }
}

