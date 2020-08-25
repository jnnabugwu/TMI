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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmi/models/friend.dart';


class FriendPage extends StatefulWidget{
  FriendPage({Key key}) : super(key: key);

  @override 
  _FriendPageState createState() => _FriendPageState();
  
}

class _FriendPageState extends State<FriendPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  TextEditingController friendidcontroller;
  Position _currentPosition;
  String _currentAddress;
  String _currentCity;
  final CollectionReference collection = Firestore.instance.collection('users');
  final Map<String,dynamic> friendata = Map<String,dynamic>();


  @override
  void initState(){
    _getCurrentLocation();
    _getAddressFromLatLng().then((value){
      print('Async done');
    });
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Request page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            FlatButton(onPressed: (){
              _getCurrentLocation();
              debugPrint('currentaddress: $_currentAddress');
              print(_currentCity);
                          }, 
                      child: Text("Get location")),
            RaisedButton(onPressed: (){
              _findUser("MeNG1QLuZcYBurrpvC55");
                          },
                textColor: Colors.blue,
                child: Text("Find User")),
            RaisedButton(onPressed: (){
              _showfrienddata();
              // print(_currentCity);
              // print(DateTime.now());
                          },
              child: Text("Show Friend data")),
            RaisedButton(onPressed: (){_sendFriendRequest("L08JH2oVAp0Obwk9Qtgh", "MeNG1QLuZcYBurrpvC55");},
            child: Text("Friend_request"),
             )
              
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }                            
                                     _getCurrentLocation() async {
                                          geolocator
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
                                                   List<Placemark> p = await geolocator.placemarkFromCoordinates(
                                                    _currentPosition.latitude, _currentPosition.longitude
                                                   );

                                                  Placemark place = p[0];
                                                  setState(() {
                                                    _currentAddress = 
                                                      "${place.locality}, ${place.postalCode}, ${place.country}";
                                                    _currentCity = "${place.locality}";
                                                  });
                                                 }catch(e){
                                                   print(e);
                                                 }
                                               }
              
                              void _findUser(String id) async {                              
                              var result = collection.where("uid", isEqualTo: "MeNG1QLuZcYBurrpvC55").getDocuments();             
                              result.then((querySnapshot) => 
                              querySnapshot.documents.forEach((result) {
                                print(result.data["name"]);
                                print(result.data["bio"]);
                                Friend newFriend = Friend(result.data["name"]);
                                newFriend.bio = result.data["bio"];
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
              collection.document(senderId).collection("friendrequest").document(recieverId).setData(
                friendata
              ).then((_) => print("success"));              
              }
              

              }
        
              
