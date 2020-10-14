

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmi/models/social.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/models/friend.dart';

class DataRepository {
  
  final CollectionReference collection = Firestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUser(User user){
    return collection.add(user.toJson());
    //when we set Unique id's we will change this. 
  }

  updateUser(User user) async {
    await collection.document(user.reference.documentID).updateData(user.toJson());
  }
  ///FRIEND Request STREAMS
    Stream<QuerySnapshot> getFriendRequestStream(String id) {
    return collection.document(id).collection('friendrequest').snapshots();
  }
  
    Future<DocumentReference> addFriendRequest(Friend friend, String id){
    return collection.document(id).collection('friendrequest').add(friend.toJson());
  }

    Future<DocumentReference> deletleFriendRequest(Friend friend, String id){
    return collection.document(id).collection('friendrequest').document(friend.reference.documentID).delete();
  }

    Future<DocumentReference> addFriend(Friend friend, String id){
    return collection.document(id).collection('friends_list').add(friend.toJson());
    
  }

  ///Friend Stream 
      Stream<QuerySnapshot> getFriendStream(String id) {
    return collection.document(id).collection('friends_list').snapshots();
  }

  ///Social Stream
     Stream<QuerySnapshot> getSocialStream(String id){
       return collection.document(id).collection('socials').snapshots();
     }

    Stream<QuerySnapshot> getSocialRequestStream(String id){
      return collection.document(id).collection('social_request').snapshots();
    }

    Future<DocumentReference> deletleSocialRequest(String id, String friendid){
      return collection.document(id).collection('social_request').document(friendid).delete();
    }

    Future<DocumentReference> shareSocials(String id, String friendId, Social user_app, Social friend_app) async {
      ///We have to set data to a json 
    // var friendUsername = await  getFriendSocialName(friendSocial);
    ///1. Get Friends Username and put under User.friend{app:username}
    ///2. Put User's username and put under Friend.User{app:username}
      await collection.document(id).collection('friends_list').document(friendId).setData(
        {
          friend_app.app : friend_app.username
        }

      );
      await collection.document(friendId).collection('friends_list').document(id).setData(
        ///Go to the friends documents then copy their social media data. 
        ///Query??? the app name in the firends socials then copy the data. 
        {
          user_app.app : user_app.username
        }
      );
      return deletleSocialRequest(id, friendId);
    }

  ///Querys
  Future<QuerySnapshot> searchSocial(String id, String appname)async {

    return await collection.document(id).collection('socials').where('app', isEqualTo: appname).limit(1).getDocuments();
  }
  
  Query findUser(String id) {
    return collection.where('uid' == id );
  }
  
}