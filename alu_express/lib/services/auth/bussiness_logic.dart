import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference dbRefvendor =
    FirebaseDatabase.instance.reference().child("Users/Vendor");
DatabaseReference dbRefclient =
    FirebaseDatabase.instance.reference().child("Users/Vendor");

FirebaseAuth _auth = FirebaseAuth.instance;

class Authentificate {
  Future registerToFb(String email, String name, String password) async {
    try {
      UserCredential results = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = results.user;
      dbRefvendor.child(user.uid).set({
        "email": email,
        "name": name,
        "userID": user.uid,
      });
      return true;
    } catch (e) {
      return Expando();
    }
  }

  Future loginwithEmailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}

class Get {

  Future<void> getCurrentUser() async {
    User userdata = FirebaseAuth.instance.currentUser;
    return userdata.uid;
  }
  
}
