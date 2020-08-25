import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FriendRequstTile extends StatelessWidget {

  final Widget thumbnail;
  final String who;
  final String bio;
  final Timestamp when;
  final String where;

  FriendRequstTile({
    @required this.thumbnail,
    @required this.who,
    @required this.bio,
    @required this.when,
    @required this.where,
  }): assert(thumbnail != null),
      assert(who != null),
      assert(bio != null),
      assert(where != null),
      assert(when !=null);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: thumbnail,
          ),
          //Create INFO CARD showing WHO WHERE WHEN
        Expanded(flex: 3, 
        child: _MeetingDetail() )
      ],
      
      ),
    );
  }



}

class _MeetingDetail extends StatelessWidget {
  const _MeetingDetail({
    Key key,
    this.who,
    this.bio,
    this.when,
    this.where
  }) : super(key: key);

  final String who;
  final String bio;
  final String when;
  final String where;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const
      EdgeInsets.fromLTRB(5.0, 0, 0, 0),
      child: Column(crossAxisAlignment: 
      CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          who,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          )
        ),
        const Padding(padding:
        EdgeInsets.symmetric(vertical: 2.0)),
        Text(
         where + " @" + when, style: const   
        TextStyle(fontSize: 10.0)),
        const Padding(padding: 
        EdgeInsets.symmetric(vertical: 1.0)),
            Text(bio, style: const TextStyle(fontSize:12.0),)
      ],),
    );
  }
}




// create class that does shows the WWWs. 