import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/social.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/profile/userDetails.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tmi/models/friendrequest.dart';
import 'package:tmi/models/tmibutton.dart';
import 'package:tmi/respository/dataRepository.dart';


//A class that creates an object that handles the interactions of socials 
//This will be a card with a social media icon, 
final CollectionReference collection = Firestore.instance.collection('users');
class TmiSocials extends StatefulWidget {
  @override
  _TmiSocialsState createState() => _TmiSocialsState();
}

class _TmiSocialsState extends State<TmiSocials> {
  String _selectedItem = '';
  // Social snapchat = Social('snapchat','pokemon');
  // final TMIUserButton _snapchat = TMIUserButton(app: 'Snapchat');
  final String userID = 'MeNG1QLuZcYBurrpvC55';
  final DataRepository repository = DataRepository();
  
///Treat socials like friends since they are having friend requests 
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Your Socials')
      ),
      body: Center
      (child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _snapchat,
            ],
          ),
      RaisedButton(child: Text('Show'),onPressed: () => _testingButton(), 
          ),
        ],
        
        ),
      )
    );
  }
      void _selectItem(String name){
      Navigator.pop(context);
      setState(() {
        _selectedItem = name;
      });
    }

    void _testingButton() async {
      var results = collection.where('uid', isEqualTo: userID).getDocuments(); 
      await results.then((value) => value.documents.forEach((element) {
        print(element.data['socials']);
       }));

    }

    // void _sendFriendRequest(String senderId, String recieverId ) async {
    //             //check if user exist(Is this necessary. planning on it not)
    //             // if not then send an alert message saying user doesnt exist 
    //             // if it does exists then give alert saying friend request sent 
    //             //In users, given a specific uid go to that document, 
    //             //then create friendsrequest collection, 
    //             //then set the uid as the title of the document
    //             //place friend data in friend request.   
    // await collection.document(senderId).collection('friendrequest').document(recieverId).setData(
    //             friendata
    //           ).then((_) => print('success'));              
    //           }    

    void _onButtonPressed(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
        return Container(
            color: Color(0xFF737373),
            height: 300,
            child: Container(
            child:_buildBottomNavigationMenu(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10) )
            ),
          ),
        );
      });
    }

    Column _buildBottomNavigationMenu() {
      return Column(children: <Widget>[
        // ListView.builder(itemBuilder: (context, index){
        //   return Card();
        // })
        Text('App Name Requests'),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Card(
                  child: Row(children: <Widget>[
                    Text('Hello $index'),
                    IconButton(icon: Icon(Icons.check), onPressed: () => print('Accept')),
                    IconButton(icon: Icon(Icons.not_interested), onPressed: () => print('Reject'))
                    ],
                  ),
                );
          }
          )          
        )
      ],);
    }
}

