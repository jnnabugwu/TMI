import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/friend.dart';
import 'package:tmi/respository/dataRepository.dart';

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold); 

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  final DataRepository repository = DataRepository();
  final String id = "MeNG1QLuZcYBurrpvC55";
  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }


  Widget _buildHome(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends List")
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getFriendStream(id),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        }
      ),
    );
  }  
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot){
    final friend = Friend.fromSnapshot(snapshot);
    if(friend == null){
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Expanded(flex: 2,child: CircleAvatar(backgroundColor: Colors.blue,child: Text(friend.name),radius: 60.0)),
            Expanded(flex: 3,
            child: Column(
              crossAxisAlignment: 
              CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  friend.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  )
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(
                    friend.where + " @" + friend.when.toDate().toString(), 
                    style: const TextStyle(fontSize: 10.0)
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0)),
                  Text(
                    friend.bio, 
                    style: const TextStyle(fontSize: 12.0)
                  ),                
              ],
            )
            ,
            )
            ,
            // FriendRequstTile(
            // bio: friend.bio, 
            // who: friend.name, 
            // when: friend.when, 
            // where: friend.where, 
            // thumbnail: CircleAvatar(backgroundColor: Colors.brown,
            // child: Text('JN'),
            // radius: 60.0,),)
          ],
        ),
          onTap: () {
            print("hello");
            ///Create a Profile page that takes a user or a friend and populates it. OR a connection page 
            
          }
      ),
    
    );
  }


}