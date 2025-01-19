import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamup/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user object based on firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return (user != null ? MyUser(uid: user.uid) : null);
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign-in w/ Email - Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign-up w/ Email - Password
  Future signUpUserWithEmailAndPassword({
    required String email,
    required String password,
    //required String username,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // register user
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;

        // add user to our database
        await _firestore.collection('users').doc(user!.uid).set({
          'email': email,
          //'username': username,
          'uid': user.uid,
        });
        return _userFromFirebaseUser(user);
      }
    } catch(err) {
      print(err.toString());
      return null;
    }
  }

  // Sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}