import 'package:alu_express_student/services/Models/food_model.dart';
import 'package:alu_express_student/services/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FirebaseServices extends ChangeNotifier {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  Stream<List<FoodModel>> getFoodList() {
    print("printing vendr id");
    return _fireStoreDataBase
        .collection('Foods')
        .where("IsFeatured", isEqualTo: 'true')
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => FoodModel.fromJson(document.data()))
            .toList());
  }

  Future<String> addStudent(data) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("Student")
        .add(data)
        .catchError((e) {
      print(e);
      // ignore: return_of_invalid_type_from_catch_error
      return e;
    });
    //DocumentReference(Foods/w09DC3zZtjCdMNtQ6e4Z)
    String docid = ref.id.toString();
    print(docid);
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(docid)
        .update({'DocumentId': docid});
    return "true";
  }

  Stream<List<UserModel>> getuser(useid) {
    print("iserviced");
    print(useid);
    return _fireStoreDataBase
        .collection('Student')
        .where("FirebaseID", isEqualTo: useid)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => UserModel.fromJson(document.data()))
            .toList());
  }

//loggout user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> updateField(docID, value, field) async {
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(docID)
        .update({field: value}).catchError((onError) {
      return onError;
    });
    return "true";
  }
}
