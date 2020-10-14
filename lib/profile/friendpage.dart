import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/friend.dart';

///Create a profile page for friends 
///Create a stateful widget that displays the socials and checks if they have permission requests 

class FriendPage extends StatelessWidget {

  FriendPage(this.friend);
  final Friend friend;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friend.name)

      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(friend.name + ' and I meet at ' + friend.where + 'on' + friend.when.toDate().toString())
              ],
            ),
          ),
          Padding(
            ///Idea display common interests once we introduce interest. 
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.cyan,
                child: Text(friend.name),
                radius: 60.0,
                ),
                Text(friend.bio ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
            style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Open Sans',
                  fontSize: 20
                  ))
              ]
            ),
          )
        ],
      ) ,
    );
  }
}