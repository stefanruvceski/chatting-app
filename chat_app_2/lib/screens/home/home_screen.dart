
// ignore: avoid_web_libraries_in_flutter


import 'package:chat_app_2/models/constants.dart';
import 'package:chat_app_2/screens/chat/chat_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        child: GridView.count(
          padding: const EdgeInsets.all(1.5),
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: MediaQuery.of(context).size.width > 1150?4:2,
           shrinkWrap: true,
            children: new List<Widget>.generate(topics.length, (index)  {
              return Container(
              padding: const EdgeInsets.all(8),
                child:FlipCard(
                  front: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10,
                  child: Center(
                    child: Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(image: AssetImage('assets/images/'+topics[index]+'.png'),height:MediaQuery.of(context).size.width > 800?200:100 ,),
                        ),
                        Text(
                          topics[index],
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 36)
                        ),
                      ], 
                    ),
                  )
                ),
                back: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10,
                  child: Center(
                    child: Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(image: AssetImage('assets/images/'+topics[index]+'.png'),height:MediaQuery.of(context).size.width > 800?200:100 ,),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            side: BorderSide(width: 1, color: Colors.white54),
                          ),
                          onPressed: ()=>joinRoom(index),
                          child: Text(
                            'Join',
                            textAlign: TextAlign.center,style: TextStyle(fontSize: 36)
                          )
                        )
                      ], 
                    ),
                  )
                ),
              ),
            );
          })
        )
      ),
    );
  }

  joinRoom(index) async{
   // if(!socket.connected){
    
   socket.on('connect', (_) {
    print('connect');
});
   // }
    //if(IO.Platform.isAndroid){
     socket.connect();
      socket.emit('join',{'username':prefs.getString('username'),'room':topics[index]});
    //}
    //else{
     // socket.emit('join',{'username':window.sessionStorage['username'],'room':topics[index]});
    //}
    

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>ChatScreen(index: index)),
    );
  }
}