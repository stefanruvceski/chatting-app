import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final url = 'https://socket-app-chatting.herokuapp.com';
//final url = 'http://localhost:5000/';
IO.Socket socket = IO.io(url,<String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
});
SharedPreferences prefs;
final topics = ['news','reading','gaming','family','coding','parties','ai','coffee','delivery','excercise','freelancers','music','newsletter','pets','photography','private','space','traveling','weather'];