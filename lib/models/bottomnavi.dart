import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmi/profile/friendslist.dart';
import 'package:tmi/profile/friendrequestlist.dart';

class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController(this.id);
  final String id;
  @override
  _BottomNavigationBarControllerState createState() => _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState extends State<BottomNavigationBarController> {
  
  int _currentIndex = 0;

  Widget getPage(int index, String id){
    if (index == 0){
      return FriendsList(widget.id);
    }
    if (index == 1) {
      return FriendRequestList(widget.id);
    }
    return FriendsList(widget.id);
    ///We can make a change to what the user sees first. 
  }

  onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends',
      home: Scaffold(
        appBar: AppBar(title: Text('Friends')),
        body: getPage(_currentIndex, widget.id),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
      items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.first_page) , title: Text('Friend')
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.last_page), title: Text('Friend Request') )
        ],
        onTap: onTabTapped(_currentIndex),
        currentIndex: _currentIndex,
        ),
      )
    );
  }
}