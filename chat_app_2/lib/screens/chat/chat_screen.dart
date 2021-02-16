
import 'dart:async';
import 'package:chat_app_2/models/chat_message.dart';
import 'package:chat_app_2/models/constants.dart';
import 'package:chat_app_2/screens/chat/message_box.dart';
import 'package:chat_app_2/screens/chat/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  ChatScreen({Key key, this.index}) : super(key: key);

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
      title:Text(topics[int.parse(widget.index.toString())],textAlign: TextAlign.center)),
      body:
        Stack(
          children: <Widget>[
            MessagesList(messages: messages,controller: controller,),
            MessageBox(messageController: messageController,room: topics[int.parse(widget.index.toString())]),
          ]
        ),
    );
  }
  backToHome(){
  {
    socket.emit('leave',{'username':prefs.getString('username'),'room':topics[int.parse(widget.index.toString())]});
    Navigator.pop(context);}
  }

  initSocket(){
    socket.on('message', (data) =>{
      if(data is List)
      {
        if(messages.isEmpty){
          for(final d in data){
            setState((){
              messages.add(ChatMessage(d['username'],d['message'],d['datetime']));
            })
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

      if(controller.hasClients){
        Timer(Duration(milliseconds: 200), () {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn
          );
        })
      }
    }); 
  }
}

