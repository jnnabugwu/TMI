import 'package:cloud_firestore/cloud_firestore.dart';
import 'social.dart';

class User {

  User(this.name,{this.bio,this.reference,this.socials});
  String name;
  String bio;
  List<Social> socials = <Social>[];
  DocumentReference reference; 

  ////create a map. 
  /// key == 
  factory User.fromSnapshot(DocumentSnapshot snapshot){
    var newUser = User.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);
  @override
  String toString() => 'User<$name>';

}

User _userFromJson(Map<String, dynamic> json){
  return User(
    json['name'] as String,
    bio :json['bio'] as String,
    socials: _convertSocials(json['socials'] as List),
  );

}

List<Social> _convertSocials(List socialMap){
  if (socialMap == null){
    return null;
  }
  var socials = <Social>[];
  socialMap.forEach((element) { 
    socials.add(Social.fromJson(element));
  });
  return socials;
}

Map<String, dynamic> _userToJson(User instance) => <String, dynamic> {
      'name': instance.name,
      'bio' : instance.bio,
      'socials': _SocialList(instance.socials),

};

List<Map<String, dynamic>> _SocialList(List<Social> socials){
  if (socials == null){
    return null;
  }
  var socialMap = <Map<String, dynamic>>[];
  socials.forEach((app) { 
    socialMap.add(app.toJson());
  });
  return socialMap;
}