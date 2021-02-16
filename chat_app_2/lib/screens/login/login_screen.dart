import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/services/user_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({ key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User user = User();
  String err = '';
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void initState() {
      super.initState();
      //baca gresku ali radi???
      // if(prefs.getString('auth') != null){
      //    Navigator.pushNamed(context, '/home');
      // }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            
             width: 400.0,
            height: 700.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  new Container(
                    margin: EdgeInsets.all(10),
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(color: Colors.white),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("https://i.imgur.com/MXgAYdh.png")
                      )
                    )
                  ),            
                  Spacer(),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        isDense: false,    
                                          
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        isDense: false,                      
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {

                        loginCheck();
                    },
                   
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 107),
                      child: Text("Sing in",
                      style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Text(err,
                    style: TextStyle(color: Colors.redAccent),),
                  ),
                  Spacer(),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  loginCheck() async {
    user.username = usernameController.text;
    user.password = passwordController.text;
    bool success = await loginUser(user);
    if(success){
       setState(() {
        err = '';
        Navigator.pushReplacementNamed(context, '/home');
      
      });
    }
    else{
      //greska
      setState(() {
        err = 'Invalid username or password';
      });
    }
  }

}