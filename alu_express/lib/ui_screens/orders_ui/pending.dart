import 'package:alu_express/services/Models/order_model.dart';
import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/services/temp_res/order_data.dart';
import 'package:alu_express/ui_screens/shared_widgets/orders_image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PendingOrders extends StatefulWidget {
  final userid;
  PendingOrders({Key key, @required this.userid}) : super(key: key);
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (BuildContext context) =>
          firebaseServices.getpendingorderList(widget.userid),
      child: Pending(),
    );
  }
}

class Pending extends StatefulWidget {
  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  Widget build(BuildContext context) {
    List pendingorders = Provider.of<List<OrderModel>>(context);

    return pendingorders == null
        ? SpinKitSquareCircle(
            color: Colors.amber,
          )
        : ListView.builder(
            itemCount: pendingorders.length,
            itemBuilder: (_, index) {
              if (pendingorders[index].orderStatus == "Pending") {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('Foods');

                return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(pendingorders[index].foodID).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(""); //omething went wrong
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text(""); //Error Food does not exist
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();

                      Map<String, dynamic> orderdetails = {
                        "image": data["ImageURL"],
                        "ordernumber": "1",
                        "time": pendingorders[index].orderTime,
                        "orderid": pendingorders[index].orderID,
                        "state": "Pending",
                        "quantity": pendingorders[index].quantity,
                        "price": data["Price"],
                        "inStock": data["Quantity"],
                        "foodName": data["FoodName"],
                        "studentId": pendingorders[index].customerID,
                        "discount": data["Discount"],
                        "size": data["Size"],
                      };
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ImageCard(
                          products: orderdetails,
                        ),
                      );
                    }

                    return SpinKitSquareCircle(
                      color: Colors.amberAccent,
                    );
                  },
                );
              }

              return Text("");
            });
  }
}
