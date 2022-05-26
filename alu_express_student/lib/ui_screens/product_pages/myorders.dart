import 'package:alu_express_student/ui_screens/homepage_ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrders extends StatefulWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser.uid;
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser.uid;
  Future getOrders(uid) async {
    Stream<QuerySnapshot> snap =
        await firebaseFirestore.collection("orders").snapshots();
  }

  Widget build(BuildContext context) {
    print(widget.uid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            userid: widget.uid,
                          )));
            },
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 0, 0, 0),
            child: Text(
              "My Orders",
              style: GoogleFonts.ptSans(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: firebaseFirestore
                .collection('orders')
                .where("customerID", isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No recent orders"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot order = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.grey[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order["foodName"],
                                    style: GoogleFonts.ptSans(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "x" + order["quantity"],
                                    style: GoogleFonts.ptSans(
                                      fontSize: 18,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  Text(
                                    "RWF " + order["total"],
                                    style: GoogleFonts.ptSans(
                                        fontSize: 18,
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    order["orderStatus"],
                                    style: GoogleFonts.ptSans(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  // Text("x" +
                                  //     snapshot.data().docs[index]["quantity"]),
                                ]),
                          )),
                    );
                  },
                );
              }
            }));
  }
}
