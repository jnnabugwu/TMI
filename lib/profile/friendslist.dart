import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/friend.dart';
import 'package:tmi/respository/dataRepository.dart';
import 'friendrequestlist.dart';

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold); 

class FriendsList extends StatefulWidget {
  const FriendsList(this.id, {PageStorageKey<String> key});
  final String id;
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  final DataRepository repository = DataRepository();
  // final String id = 'MeNG1QLuZcYBurrpvC55';
  // int _currentIndex = 0;
  // List _listPages = [];
  // Widget _currentPage;
  
  @override
  // void initState(){
  //   super.initState();
  //   _listPages
  //     ..add(FriendsList(widget.id))
  //     ..add(FriendRequestList(widget.id));
  //     _currentPage = FriendsList(widget.id);
  // }

  // void _changePage(int selectedIndex) {
  //   print(selectedIndex);
  //   setState(() {
  //     _currentIndex = selectedIndex;
  //     _currentPage = _listPages[selectedIndex];
  //   });
    
  // }
  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }


  Widget _buildHome(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List')
      ),
      body: ListView(
        children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           IconButton(icon: Icon(Icons.person_add), onPressed: () { 
          void _navigate(BuildContext context) {
            Navigator.push(context, 
            MaterialPageRoute(builder: 
            (context) => FriendRequestList(
              widget.id
              )
            )
            );
          }
          _navigate(context);
            },
            ),
          StreamBuilder<QuerySnapshot>(
          stream: repository.getFriendStream(widget.id),
          builder: (context, snapshot)
          {
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildList(context, snapshot.data.documents);
          }
        ),
          
        ],
      )
        ])
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
                    friend.where + ' @' + friend.when.toDate().toString(), 
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
            print('hello');
            ///Create a Profile page that takes a user or a friend and populates it. OR a connection page 
            
          }
      ),
    
    );
  }


}