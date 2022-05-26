import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveCategory(data) async {
  FirebaseFirestore.instance.collection("categories").add(data).catchError((e) {
    print(e);
  });
}

Future<DocumentReference> saveProduct(data) async {
  DocumentReference ref = await FirebaseFirestore.instance
      .collection("products")
      .add(data)
      .catchError((e) {
    print(e);
  });
  return ref;
}

Future<String> saveSide(data) async {
  FirebaseFirestore.instance.collection("sides").add(data).catchError((e) {
    print("There is an error on the menu funtions");
    print(e);
    return e;
  });
  return "OK";
}
