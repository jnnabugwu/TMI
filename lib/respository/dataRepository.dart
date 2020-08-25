

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/models/friend.dart';

class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUser(User user){
    return collection.add(user.toJson());
  }

  updateUser(User user) async {
    await collection.document(user.reference.documentID).updateData(user.toJson());
  }
  ///FRIEND STREAMS
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

  findUser(String id) {
    return collection.where("uid" == id );
  }

}