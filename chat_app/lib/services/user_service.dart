import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:chat_app/Models/constants.dart';
import 'package:chat_app/Models/user.dart';
import 'package:http/http.dart' as http;

Future<bool> loginUser(User user) async {
 

  final response = await http.post(
    url+'/login',
    body: {
      'username': user.username,
      'password': user.password
    }
  );
  Map<String, dynamic> res = jsonDecode(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    print(res['response']);
    window.sessionStorage['auth'] = res['response'].toString();
    window.sessionStorage['username'] = user.username;
    return true;
  }
  else{
    print(res['response']);
    return false;
  }
  
}

