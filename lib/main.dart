import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/Chats.dart';
// import 'screens/Auth_Screen.dart';
import 'screens/Log_In_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.white,
      ),
      // home: ChatScreen(),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx,userSnapShot){
        if(userSnapShot.hasData)
        {
         return ChatScreen();
        }
        return LogInScreen();
      },),
      // home: LogInScreen2(),
      routes: {
        // LogInScreen.Routename: (ctx) => LogInScreen(),
        // AuthScreen.Routename: (ctx) => AuthScreen(),
      },
    );
  }
}
