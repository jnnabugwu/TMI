import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/tmibutton.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/profile/friendslist.dart';
import 'package:tmi/respository/dataRepository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmi/profile/userDetails.dart';
import 'package:tmi/models/social.dart';
import 'tmisocials.dart';

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
        _interests,

        SocialDisplay(user.reference.documentID.toString())
        
        ],)
      ]
    ),


    );
  }
  
}

///Create a list of social cards from snapshots of the user's social database. 
class SocialDisplay extends StatefulWidget {
  SocialDisplay(this.id);
  final String id;
  @override
  _SocialDisplayState createState() => _SocialDisplayState();
}

class _SocialDisplayState extends State<SocialDisplay> {
  final DataRepository socialRepository = DataRepository();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      StreamBuilder<QuerySnapshot>(stream: socialRepository.getSocialStream(widget.id), builder: (context, snapshot){
        if(!snapshot.hasData) return Container(child: Text('Blank'));
        return _buildList(context, snapshot.data.documents);
      }
      )
    );
  }



  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),   
               );
}
///Lets take this _friendsocial outside of the area 
  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot)  {
      final social = Social.fromSnapshot(snapshot);
      ///Below is a querysnapshot use then in it
      // String _friendSocialName;
      // await _friendSocial.then((value) => value.documents.forEach((element) {
      //   setState(() {
      //     _friendSocialName = element.data['username'];
      //   });
      // }));
      if(social == null){
        return Container();
      }

            return Container(
              ///create a card that holds the TMIuserbutton
              ///Displays the app name from document snapshot 
              child: Card(
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center, 
                  children:
                [
                  Text(social.app),
                  ///Changed to passing social instead the app name  
                  TMIUserButton(user_social: social, id: widget.id),
                  // RaisedButton(onPressed: () => 
                  //   // print(socialRepository.searchSocial(widget.id, social.app))
                  //   //fIGURUE OUT A WAY TO MAKE THIS WORK. 
                  
                   
            
                  //         ),
                        ]
                        ),
                      ),
                    );
              
              }
              
                
  

  

}



//TODO: Create a Button to switch between states 


