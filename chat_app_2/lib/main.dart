

import 'package:chat_app_2/screens/chat/chat_screen.dart';
import 'package:chat_app_2/screens/home/home_screen.dart';
import 'package:chat_app_2/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
         '/chat': (context) => ChatScreen(index: 1),
      },
      title: 'Chatting App',
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}
