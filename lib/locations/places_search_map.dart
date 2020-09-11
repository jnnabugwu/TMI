import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PlacesSearchMapSample extends StatefulWidget{
  // final String keyword; THIS IS FOR CREATING A CLASS AND PASSING VARIABLES THROUGH THAT CLASS
  // PlacesSearchMapSample(this.keyword);

  @override
  _PlaceSearchMapSampleState createState() => _PlaceSearchMapSampleState();

}

class _PlaceSearchMapSampleState extends State<PlacesSearchMapSample> {
    static const String _API_KEY = 'AIzaSyCs2X3gpmaK2F_1OHWPiu87pS1-hD--PNI';

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _myLocation = CameraPosition(target: LatLng(0, 0),);

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: GoogleMap(onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
      zoom: 11.0),
      ),
    );
  }

}



