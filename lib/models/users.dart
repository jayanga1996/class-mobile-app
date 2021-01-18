import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String email;
  String password;
  String regNum;

  DocumentReference documentReferance;

  Users({this.email, this.password, this.regNum});

  Users.fromMap(Map<String, dynamic> map, {this.documentReferance}) {
    email = map['email'];
    password = map['password'];
    regNum = map['regNum'];
  }
  Users.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, documentReferance: snapshot.reference);

  tojson() {
    return {'email':email,'password':password,'regNum':regNum};
  }
}
