///Create a Listtile view of Friend requests 
/// For every Friend map in Friend requests 
/// ListView builder them with the time 
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/friend.dart';
import 'package:tmi/respository/dataRepository.dart';
import 'package:tmi/models/friendrequest.dart';

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold); 

class FriendRequestList extends StatefulWidget{
  @override
  _FriendRequestListState createState() => _FriendRequestListState();

}

class _FriendRequestListState extends State<FriendRequestList> {

  final DataRepository repository = DataRepository();
  final String id = "MeNG1QLuZcYBurrpvC55";
  @override
  Widget build(BuildContext context){
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Request List")
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getFriendRequestStream(id),
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
            _choseFriend(friend);
            
          }
      ),
    
    );
  }
/// Create a Alertdialog button. 
/// Does not disappear after 
Future<DocumentReference> _choseFriend(Friend friend) async{
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
        return AlertDialog(
    title: const Text("Do you want to add contact?"),
    actions: <Widget>[
      FlatButton(onPressed: () {
        print("Reject");
        repository.deletleFriendRequest(friend, id);
        Navigator.of(context).pop();
        }, 
        child: Text("Reject", style: TextStyle(color: Colors.blue) ,),
      ),
      RaisedButton(onPressed: (){
        repository.addFriend(friend, id);
        repository.deletleFriendRequest(friend, id);
        print("Accept");
        Navigator.of(context).pop();
      },color: Colors.blue, child: Text("Accept"),
      )
    ],
  );
    }
    );
}

}
// change the function of this. 
// Aim to be a popup function. 

