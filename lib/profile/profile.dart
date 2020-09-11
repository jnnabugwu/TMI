import 'dart:developer';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class DebugUiPage extends StatefulWidget {
  DebugUiPage({Key key}) : super(key: key);

  @override
  _DebugUiPageState createState() => new _DebugUiPageState();
}

//TODO: Create a Button to switch between states 



class _DebugUiPageState extends State<DebugUiPage> {

String title = "Old Title";

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
  child: Text('JN'),
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
          child: Text("I love psychology and traveling. I\'m a big music head and concert go-er. If you music recommendations I\'M YOUR GUY",
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
        title: Text(title),
        onTap: () {
          setState(() {
            if(title == "Monkey") {
              title = "Goat";
            }else{
              title = "Monkey";
            }
          });
        } ,
      ),
    ),
    Card(
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.snapchatGhost, color: Colors.yellow,),
        title: Text('One-line with both widgets'),
        trailing: Icon(Icons.more_vert),
      ),
    ),
    Card(
          child: ListTile(
          leading: FaIcon(FontAwesomeIcons.twitterSquare, color: Colors.blue),
          title: Text('One-line with both widgets'),
          trailing: Icon(Icons.more_vert),
      ),
    )
  ],
)     
            
    )
    ;
  }
}