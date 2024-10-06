import 'package:Coffee_Shop_Application/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Database/app_user.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        currentUser = AppUser.fromDocument(userDoc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fourthColour,
        title: const Text('User Profile'),
      ),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Icon(Icons.account_circle_sharp, size: 120,)),
            const SizedBox(height: 15,),
            Center(child: Text('${currentUser!.firstname} ${currentUser!.lastname}',style: const TextStyle(fontSize: 25))),
            const SizedBox(height: 15,),
            const Divider(),
            const ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("ACCOUNT DETAILS", style: TextStyle(fontSize: 23),),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Username: ', style: TextStyle(fontSize: 20)),
              subtitle: Text(currentUser!.username,style: const TextStyle(fontSize: 18),),
            ),
            ListTile(
              leading: const Icon(Icons.note_alt_sharp),
              title: const Text('First Name: ', style: TextStyle(fontSize: 20)),
              subtitle: Text(currentUser!.firstname,style: const TextStyle(fontSize: 18),),
            ),
            ListTile(
              leading: const Icon(Icons.note_alt_sharp),
              title: const Text('Last Name: ', style: TextStyle(fontSize: 20)),
              subtitle: Text(currentUser!.lastname,style: const TextStyle(fontSize: 18),),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email: ', style: TextStyle(fontSize: 20)),
              subtitle: Text(currentUser!.email,style: const TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }
}
