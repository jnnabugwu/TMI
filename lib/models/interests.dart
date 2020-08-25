import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///info about [Interest]
///

class Interest {
 String activity;
 FaIcon interestIcon;


 Interest({
    @required this.activity,
    @required this.interestIcon,
}) : assert(activity != null),
     assert(interestIcon != null);


}



