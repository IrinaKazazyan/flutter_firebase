import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//   create user object based on firebaseUser
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

//  auth change user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
//        .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser))
        .map(_userFromFirebaseUser);
  }

//  sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//  sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
