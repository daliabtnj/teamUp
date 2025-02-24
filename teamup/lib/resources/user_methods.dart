import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamup/models/user.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update User bio (returns true if successful, returns null if error)
  Future updateUserBio(MyUser user, String bio) async {
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'bio': bio,
      });
      user.bio = bio;
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update Username (returns true if successful, returns null if error)
  Future updateUserUsername(MyUser user, String username) async {
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'username': username,
      });
      user.username = username;
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}