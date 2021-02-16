import 'package:chat_app_2/models/constants.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  final messages;
  final controller;
  MessagesList({Key key,this.messages,this.controller}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context)  {
    return ListView.builder(
      controller: widget.controller,
      itemCount: widget.messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10,bottom: 60),
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Align(
            alignment: (widget.messages[index].username != prefs.getString('username')?Alignment.topLeft:Alignment.topRight),
            child: Container(
              constraints: BoxConstraints( maxWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (widget.messages[index].username != prefs.getString('username')?Colors.purple.shade200:Colors.blue[200]),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.messages[index].username + ' ' +widget.messages[index].datetime, style: TextStyle(fontSize: 10,color: Colors.white54))
                    ),
                  ),
                  Text(widget.messages[index].message, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  
}


