import 'package:firebase_database/firebase_database.dart';

class UserInfoo {
   String?  uid;
   String?  phoneNumber;
   String? photoUrl;
   String? name;
   String? userName;
   String? bio;

  UserInfoo({required this.uid,required this.phoneNumber, required this.photoUrl, required this.name,required this.userName, required this.bio});


  UserInfoo.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    phoneNumber =  (dataSnapshot.child("phoneNumber").value.toString());
    photoUrl =  (dataSnapshot.child("photoUrl").value.toString());
    name =  (dataSnapshot.child("name").value.toString());
    userName =  (dataSnapshot.child("userName").value.toString());
    bio =  (dataSnapshot.child("bio").value.toString());
  }
}

