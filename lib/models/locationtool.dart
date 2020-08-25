//create a inputtextfiedl for uid
//place 
//city
//search for a user with a uid
//take the bio, name, uid, city, place, time,  and put in a map called friend 
//write friend data in friends_list
//Lets first test the location == city function
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


class LocationPage extends StatefulWidget{
  LocationPage({Key key}) : super(key: key);

  @override 
  _LocationPageState createState() => _LocationPageState();
  
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  TextEditingController friendidcontroller;
  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currentPosition == null ? CircularProgressIndicator() :
            Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}")
            ,
            FlatButton(onPressed: (){
              _getCurrentLocation();
              debugPrint('currentaddress: $_currentAddress' );
                          }, 
                          child: Text("Get location")),
                        ],
                      ),
                    ),
                  );
                }
              
              _getCurrentLocation() {
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
                      });
                     }catch(e){
                       print(e);
                     }
                   }

}