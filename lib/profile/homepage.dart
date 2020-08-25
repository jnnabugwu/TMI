import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmi/respository/dataRepository.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/profile/profile.dart';
import 'package:tmi/database/profile_edit.dart';
import 'package:tmi/profile/userDetails.dart';


const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold); 

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TMI User"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot)
        {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        } 
        ), // TODO Add StreamBuilder
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        tooltip: 'Add User',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

   void _addUser() {
    AlertDialogWidget dialogWidget = AlertDialogWidget();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add User"),
              content: dialogWidget,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      // TODO Add New User to repository
                      Navigator.of(context).pop();
                      User newUser = User(dialogWidget.name);
                      repository.addUser(newUser);
                    },
                    child: Text("Add")),
              ]);
        });
  }
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) { // TODO Add Snapshot list
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot){
    final user = User.fromSnapshot(snapshot);
    if (user == null) {
       Container();
    }



    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Expanded(child: Text(user.name == null ? "" : user.name, style: BoldStyle)) // TODO add pet name
               // TODO Add pet type
            ],
          ),
          onTap: () {
            _navigate(BuildContext context)  {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => PetDetails(),
                     // TODO add pet
                     builder: (context) => UserDetails(user),
                  ));
            }

            _navigate(context);      
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));

  }
  

}

class AlertDialogWidget extends StatefulWidget {
  String name;

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
  
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Name"
            ),
            onChanged: (text) => widget.name = text,
          )
        ],
      )
    );    
  }
}
