//create a inputtextfiedl for uid
//place 
//city
//search for a user with a uid
//take the bio, name, uid, city, place, time
//,  and put in a map called friend 
//write friend data in friends_list
//Lets first test the location == city function
// MAKING A HARD ASSUMTION THAT THE CURRENT ADDRESS WILL BE SET 
// Why does it take long to find the location? maybe it wont be a problem on a real device ***hopefully***
// change the friendrequest page 


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmi/models/friend.dart';

class NewFriendPage extends StatefulWidget{
  NewFriendPage({Key key}) : super(key: key);

  @override 
  _NewFriendPageState createState() => _NewFriendPageState();
  
}

class _NewFriendPageState extends State<NewFriendPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  TextEditingController friendidcontroller;
  Position _currentPosition;
  String _currentAddress;
  String _currentCity;
  final CollectionReference collection = Firestore.instance.collection('users');
  final Map<String,dynamic> friendata = <String,dynamic>{};
  
  int _value = 1;
  final Map<String,List> locations = <String,List>{};
  
                
  
  @override
  void initState(){
    _getCurrentLocation();
    _getAddressFromLatLng().then((value){
      print('Async done');
      locations['st.pete'] = [27.705010, -82.651163];
      locations['baltimore'] = [39.290386, -76.612190];
      locations['DC'] = [38.900497, -77.007507];
      locations['Atlanta'] = [33.748997, -84.387985];
    }
    
    
    );
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Request page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            DropdownButton(
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text('St.Pete'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('Baltimore'),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text('Washington'),
                  value: 3,
                ),
                DropdownMenuItem(
                  child: Text('Atlanta'),
                  value: 4,
                )
              ],
              onChanged: (value){
                setState((){
                _value = value; 
                });
              }
              ),

            FlatButton(onPressed: (){
              _getCurrentLocation();
              debugPrint('currentaddress: $_currentAddress');
              print(_currentCity);
                          }, 
                      child: Text('Get location')),
            FlatButton(onPressed: () {
              if(_currentPosition == null){
                print('blank');
              }
              _getAddress(locations);
            } 
            , child: Text('click this afterwards')),
            RaisedButton(onPressed: (){
              _findUser('MeNG1QLuZcYBurrpvC55');
                          },
                textColor: Colors.blue,
                child: Text('Find User')),
            RaisedButton(onPressed: (){
              _showfrienddata();
              // print(_currentCity);
              // print(DateTime.now());
                          },
              child: Text('Show Friend data')),
            RaisedButton(onPressed: (){_sendFriendRequest('L08JH2oVAp0Obwk9Qtgh', 'MeNG1QLuZcYBurrpvC55');},
            child: Text('Friend_request'),
             )
              
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }                            
                                     _getCurrentLocation() async {
                                          await geolocator
                                            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                                            .then((Position position){
                                          setState(() {
                                            _currentPosition = position;
                                          });
                                            _getAddressFromLatLng();
                                                            }).catchError((e) {
                                                              print(e);
                                                            });
                                                          }
                                          
                                          _getAddressFromLatLng() async {
                                                 try{
                                                   var p = await geolocator.placemarkFromCoordinates(
                                                    _currentPosition.latitude, _currentPosition.longitude
                                                   );

                                                  var place = p[0];
                                                  setState(() {
                                                    _currentAddress = 
                                                      '${place.locality}, ${place.postalCode}, ${place.country}';
                                                    _currentCity = '${place.locality}';
                                                  });
                                                 }catch(e){
                                                   print(e);
                                                 }
                                               }
              
                              void _findUser(String id) async {                              
                              var result = collection.where('uid', isEqualTo: 'MeNG1QLuZcYBurrpvC55').getDocuments();             
                              await result.then((querySnapshot) => 
                              querySnapshot.documents.forEach((result) {
                                print(result.data['name']);
                                print(result.data['bio']);
                                var newFriend = Friend(result.data['name']);
                                newFriend.bio = result.data['bio'];
                                newFriend.when = Timestamp.now();
                                newFriend.where = _currentCity;
                               })              
                              );
                             }
              void _showfrienddata() {
                print(friendata);
              }
              void _sendFriendRequest(String senderId, String recieverId ) async {
                //check if user exist(Is this necessary. planning on it not)
                // if not then send an alert message saying user doesnt exist 
                // if it does exists then give alert saying friend request sent 
                //In users, given a specific uid go to that document, 
                //then create friendsrequest collection, 
                //then set the uid as the title of the document
                //place friend data in friend request.   
              await collection.document(senderId).collection('friendrequest').document(recieverId).setData(
                friendata
              ).then((_) => print('success'));              
              }
                // void _getAddress(Map<String,List> placemarks, value) async {
                // // ignore: omit_local_variable_types
 
                // if (placemarks != null && placemarks.isNotEmpty) {
                //   // ignore: omit_local_variable_types
                //   // lets us the placemarks[value] = coordinates
                //   // pass coordinates to geolocater. 
                //   // final Placemark pos = placemarks[0];
                //   print(pos.thoroughfare + ', ' + pos.locality);
                //   }
                  ///Next place locations in hte drop down then do friend sharing to complete the geocoding 
  }

              }
        
              
