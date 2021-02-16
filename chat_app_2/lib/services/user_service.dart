import 'dart:io' as IO;
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter


import 'package:chat_app_2/models/constants.dart';
import 'package:chat_app_2/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> loginUser(User user) async {
 

  final response = await http.post(
    Uri.parse(url+'/login'),
    body: {
      'username': user.username,
      'password': user.password
    }
  );
  Map<String, dynamic> res = jsonDecode(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    if (IO.Platform.isAndroid){
        prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth', res['response'].toString());
        await prefs.setString('username', user.username);
    }
    else{
     // window.sessionStorage['auth'] = res['response'].toString();
     // window.sessionStorage['username'] = user.username;
    }
    return true;
  }
  else{
    print(res['response']);
    return false;
  }
  
}



