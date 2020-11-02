import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmi/models/social.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/respository/dataRepository.dart';
///TMIUserButton will be displayed on User's profile to show their socials
///Takes in appname as a parameter. 
///OnTap brings up modal that has the TMIRequests populated 
///Might take in the path to the database instead. 
///take in color??? so it changes with having a request.
///This class will handle the modal functionality 
///Have a details button to go to the individuals profile 


class TMIUserButton extends StatefulWidget {
  ///TMIUserButton will be displayed on User's profile to show their socials
  ///Takes in appname as a parameter. 
 

  TMIUserButton({@required this.user_social,@required this.id}): assert(user_social != null, id != null); 
  final Social user_social;
  final String id;
  @override
  _TMIUserButtonState createState() => _TMIUserButtonState();
}

class _TMIUserButtonState extends State<TMIUserButton> {
  @override
  final DataRepository socialRepository = DataRepository();
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(child: Text(widget.user_social.app),onPressed: () => _onButtonPressed()),
    );
  }

      void _onButtonPressed(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
        return Container(
            color: Color(0xFF737373),
            height: 180,
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
        
        Text(widget.user_social.app +' Name Requests'),
        ///Create a stream of Social Requests 
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: socialRepository.getSocialRequestStream(widget.id,widget.user_social.app),
            builder: (context, snapshot){
              if(!snapshot.hasData) return Container(child: Text('All caught up'));
              return _buildList(context, snapshot.data.documents);
            },
          ),
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   itemBuilder: (context, index){
          //     return Card(
          //         child: Row(
          //           children: <Widget>[
          //           Text('Hello $index'),
          //           IconButton(icon: Icon(Icons.check), onPressed: () => print('Accept')),
          //           IconButton(icon: Icon(Icons.not_interested), onPressed: () => print('Reject'))
          //           ],
          //         ),
          //       );
          //     }
          // )          
        )
      ],);
    }
    
    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top:20), 
        children: snapshot.map((data) => _buildListItem(context, data)).toList());
    }

    Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot){
      final friend_social = Social.fromSnapshot(snapshot);
      ///what does this item have? 
      ///answer: a social request 
      ///the person's name and two iconbuttons accept and reject 
      if(friend_social == null){
        return Container();
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          child: Row(
            children:[
              ///need to have name of person here can problably pull from reference. 
              Text(friend_social.name),
              RaisedButton.icon(onPressed: () => socialRepository.shareSocials(widget.id, friend_social.id, widget.user_social, friend_social), icon: Icon(Icons.check), label: Text('Accept')),
              RaisedButton.icon(onPressed: () => print('reject ' + friend_social.id), icon: Icon(Icons.not_interested), label: Text('Reject'))
            ]
          )        ),
      );

    }

        
    Future<String> getFriendSocialName(QuerySnapshot friendSocial) async {
      await friendSocial.documents.forEach((element) {
        return element.data['username'];
      });
    } 
    
       
}

class TMIFriendButton extends StatefulWidget {

  TMIFriendButton({@required this.app, @required this.id}): assert(app != null, id !=null); 
  final Social app;
  final String id;

  @override
  _TMIFriendButtonState createState() => _TMIFriendButtonState();
}

class _TMIFriendButtonState extends State<TMIFriendButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        RaisedButton(onPressed: _onButtonPressed),
              
            );
          }
        
          void _onButtonPressed() {
  }
}