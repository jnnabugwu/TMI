import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Social {
  String app;
  String username;
  bool permission;

  DocumentReference reference;
  

  Social(this.app,{this.username,this.permission,this.reference});
  //might have to make it a map like how note did but idk.

  Map<String, dynamic> toJson() => _SocialToJson(this);

  factory Social.fromJson(Map<dynamic, dynamic> json) => 
  _SocialFromJson(json);

}

Social _SocialFromJson(Map<dynamic, dynamic> json) {
  return Social(
    json['app'] as String,
    username: json['username'] as String,
    permission: json['permission'] as bool,
  );
}

Map<String, dynamic> _SocialToJson(Social instance) =>
  <String, dynamic> {
    'app' : instance.app,
    'username': instance.username,
    'permission': instance.permission,
  };




