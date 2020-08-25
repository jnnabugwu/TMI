import 'dart:developer';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key key}) : super(key: key);

  @override
  _ProfileEditState createState() => new _ProfileEditState();
}


String _username = "Jay";

String _bio = "I love psychology and traveling. I\'m a big music head and concert go-er. If you music recommendations I\'M YOUR GUY";

String insta_name = "jnnabugwu";
String snap_name = "diala72795";
String twitter_name = "deltaflow_J";


bool insta_name_access = true;
bool snap_name_access = false;
bool twitter_name_access = true;



class _ProfileEditState extends State<ProfileEdit> {



Widget _interests = Row(
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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Profile"),
        ),
        body:
       ListView(
  children:  <Widget>[
    Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 32.0, 12.0,12.0),
      child: CircleAvatar(
  backgroundColor: Colors.brown,
  child: Text(_username),
  radius: 60.0,
        ),
    ), 

    Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Interests",
          style: TextStyle(fontSize: 24)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_bio,
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
      ],
    ),

    Card(
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.instagram, color: Colors.deepPurple,),
        title: Text(insta_name),
        onTap: () {
          setState(() {
            //Flip switch instead of reading text 

          });
        },
      ),
    ),
    Card(
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.snapchatGhost, color: Colors.yellow,),
        title: Text(snap_name),
        trailing: Icon(Icons.more_vert),
      ),
    ),
    Card(
          child: ListTile(
          leading: FaIcon(FontAwesomeIcons.twitterSquare, color: Colors.blue),
          title: Text(twitter_name),
          trailing: Icon(Icons.more_vert),
      ),
    )
  ],
)     
            
    )
    ;
  }
}