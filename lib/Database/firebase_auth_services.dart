import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password, String username, String firstname, String lastname) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.message}');
      }
    } catch (e) {
      showToast(message: 'An unknown error occurred.');
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email , String password) async{

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found' || e.code == 'wrong-password'){
        showToast(message: 'Invalid E-mail or Password.');
      }else{
        showToast(message: 'An Error Occured: ${e.code}');
      }
    }

    return null;

  }

}