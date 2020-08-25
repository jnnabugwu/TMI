import 'package:flutter/material.dart';
import 'package:tmi/profile/friendslist.dart';
import 'package:tmi/profile/homepage.dart';
import 'package:tmi/profile/userDetails.dart';
import 'package:tmi/profile/friends.dart';
import 'package:tmi/profile/friendrequestlist.dart';
import 'package:tmi/profile/searching.dart';

void main() => runApp(MyApp());
  
const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);  
//  MaterialApp(
//    title: 'Display',
//    initialRoute: 'home',
//    routes: {
//     //  '/': (context) => QRdisplay()
//      '/': (context) => ProfileEdit()
//    },
//    theme: ThemeData(primarySwatch: Colors.red,),
//   )
//   );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'TMI database',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchScreen());
  }
}

