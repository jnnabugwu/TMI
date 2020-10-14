import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Social {
  
  factory Social.fromJson(Map<dynamic, dynamic> json) => 
  _socialFromJson(json);
    
  factory Social.fromSnapshot(DocumentSnapshot snapshot){
    var newSocial = Social.fromJson(snapshot.data);
    newSocial.reference = snapshot.reference;
    return newSocial;
  }
  Social(this.app,{this.username,this.name,this.reference});
  String app;
  String username;
  String name; 

  DocumentReference reference;
  
  //might have to make it a map like how note did but idk.

  Map<String, dynamic> toJson() => _socialToJson(this);



}

Social _socialFromJson(Map<dynamic, dynamic> json) {
  return Social(
    json['app'] as String,
    username: json['username'] as String,
    name: json['name'] as String
  );
}

Map<String, dynamic> _socialToJson(Social instance) =>
  <String, dynamic> {
    'app' : instance.app,
    'username': instance.username,
    'name': instance.name
  };




