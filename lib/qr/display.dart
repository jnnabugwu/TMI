import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

//Create an stateful widget 
//First create a qr code display off of some random text 
//Then off of a user inpurted text. 
//


class QRdisplay extends StatefulWidget {
  @override
  State createState() => QRdisplaystate();
}

class QRdisplaystate extends State<QRdisplay> {

  
  Widget _buildBody(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Hello"),
            subtitle: Text("hey hey"),
          ),        
        QrImage(
          data: 'Hello Simon',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
        const SizedBox(height: 30),
        RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: const Text('Profile', style: TextStyle(fontSize: 20)))
        ],
        
        );
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text('Display QR code'),
      ),
      body: ConstrainedBox(constraints: const BoxConstraints.expand(),
      child: _buildBody(),
      ));
  }
}