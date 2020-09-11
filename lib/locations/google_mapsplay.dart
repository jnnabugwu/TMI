import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tmi/locations/locations.dart' as locations;


class GoogleMapsPlayground extends StatefulWidget{
  @override
  _GoogleMapsPlaygroundState createState() => _GoogleMapsPlaygroundState();
}

class _GoogleMapsPlaygroundState extends State<GoogleMapsPlayground>{
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController conrtoller) async{
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          )
          );
          _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2.0),
          markers: _markers.values.toSet(),
        ),
      ),        
    );
  }


}