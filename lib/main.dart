import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:async';

import 'dart:math';
import 'package:tmi/profile/friendslist.dart';
import 'package:tmi/profile/homepage.dart';
import 'package:tmi/profile/userDetails.dart';
import 'package:tmi/profile/friends.dart';
import 'package:tmi/profile/friendrequestlist.dart';
import 'package:tmi/profile/searching.dart';
import 'package:tmi/locations/places_search_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tmi/locations/locations.dart' as locations;
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tmi/profile/tmisocials.dart';



void main() => runApp(MyApp());

const kGoogleApiKey = 'AIzaSyCs2X3gpmaK2F_1OHWPiu87pS1-hD--PNI';  
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

const BoldStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);  
//  MaterialApp(
//    title: 'Display',
//    initialRoute: 'home',
//    routes: {
//     //  '/': (context) => QRdisplay()
//      '/': (context) => ProfileEdit()
//    },
//    theme: ThemeData(primarySwatch: Colors.red,),
//   )
//   );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'TMI database',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeList());
  }
}

