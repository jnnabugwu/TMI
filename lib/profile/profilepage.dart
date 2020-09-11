import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/profile/friendslist.dart';
import 'package:tmi/respository/dataRepository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmi/profile/userDetails.dart';
import 'package:tmi/models/bottomnavi.dart';

class ProfilePage extends StatelessWidget{

  ProfilePage(this.user);
  final User user; 
  final DataRepository repository = DataRepository();

  final Widget _interests = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    FaIcon(FontAwesomeIcons.planeDeparture),
    FaIcon(FontAwesomeIcons.basketballBall),
    FaIcon(FontAwesomeIcons.music),
    FaIcon(FontAwesomeIcons.bookReader),
  ],
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            void _gotosettings(BuildContext context){
              Navigator.push(context, 
              MaterialPageRoute(builder: 
              (context) => UserDetails(user)
              )
              );
            }
            _gotosettings(context);
          } ,)
        
      ),
    body: ListView(
      
      children: <Widget>[
        Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           IconButton(icon: Icon(Icons.person), onPressed: () { 
          void _navigate(BuildContext context) {
            Navigator.push(context, 
            MaterialPageRoute(builder: 
            (context) => FriendsList(
              user.reference.documentID.toString()
              )
            )
            );
          }
          _navigate(context);
            },)
           
         ],
        ),
        Padding(padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
        child: CircleAvatar(
          backgroundColor: Colors.cyan,
          child: Text(user.name),
          radius: 60.0,
          ),
        ),

        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Interests', 
              style: TextStyle(fontSize: 24)),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
            child: Text(user.bio,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
              fontSize: 20
            ),
            ),
          ),
        _interests
        ],)
      ]
    ),


    );
  }
  
}

//TODO: Create a Button to switch between states 


