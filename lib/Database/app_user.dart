import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String username;
  final String firstname;
  final String lastname;

  AppUser({
    required this.uid,
    required this.email,
    required this.username,
    required this.firstname,
    required this.lastname,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      uid: doc['uid'],
      email: doc['email'],
      username: doc['username'],
      firstname: doc['firstname'],
      lastname: doc['lastname'],
    );
  }
}
