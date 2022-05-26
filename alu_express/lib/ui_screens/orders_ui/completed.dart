import 'package:alu_express/services/Models/order_model.dart';
import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/services/temp_res/order_data.dart';
import 'package:alu_express/ui_screens/shared_widgets/orders_image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CompletedOrders extends StatefulWidget {
  final userid;
  CompletedOrders({Key key, @required this.userid}) : super(key: key);
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (BuildContext context) =>
          firebaseServices.getCompletedList(widget.userid),
      child: Completed(),
    );
  }
}

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  Widget build(BuildContext context) {
    List Completedorders = Provider.of<List<OrderModel>>(context);

    return Completedorders == null
        ? SpinKitSquareCircle(
            color: Colors.amber,
          )
        : ListView.builder(
            itemCount: Completedorders.length,
            itemBuilder: (_, index) {
              if (Completedorders[index].orderStatus == "Completed") {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('Foods');

                return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(Completedorders[index].foodID).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(""); //Something went wrong
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text(""); //Error Food does not exist
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      Map<String, dynamic> orderdetails = {
                        "image": data["ImageURL"],
                        "ordernumber": "1",
                        "time": Completedorders[index].orderTime,
                        "orderid": Completedorders[index].orderID,
                        "state": "Completed",
                        "quantity": Completedorders[index].quantity,
                        "price": data["Price"],
                        "inStock": data["Quantity"],
                        "foodName": data["FoodName"],
                        "studentId": Completedorders[index].customerID,
                        "discount": data["Discount"],
                        "size": data["Size"],
                      };
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ImageCard(
                          products: orderdetails,
                        ),
                      );
                      ;
                    }

                    return Text("loading");
                  },
                );
              }

              return Text(""); //Empty
            });
  }
}
