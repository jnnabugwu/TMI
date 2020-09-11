//Make a model friend
//similair to user 
//fieilds are name, bio, reference, city, Datetime
import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {

  Friend(this.name, {this.bio,this.when,this.where,this.reference});
  String name;
  String bio;
  String where;
  Timestamp when;

  DocumentReference reference;
  
  factory Friend.fromSnapshot(DocumentSnapshot snapshot){
    var newFriend = Friend.fromJson(snapshot.data);
    newFriend.reference = snapshot.reference;
    return newFriend;
  }

  factory Friend.fromJson(Map<String, dynamic> json) => _friendFromJson(json);

  Map<String, dynamic> toJson() => _friendToJson(this);
  @override
  String toString() => 'Friend<$name>';

}

Friend _friendFromJson(Map<String, dynamic> json){
  return Friend(
    json['name'] as String,
    bio: json['bio'] as String,
    where: json['where'] as String,
    when: json['when'] as Timestamp
  );
}

Map<String, dynamic> _friendToJson(Friend instance) => <String, dynamic> {
      'name': instance.name,
      'bio' : instance.bio,
      'where': instance.where,
      'when' : instance.when
};