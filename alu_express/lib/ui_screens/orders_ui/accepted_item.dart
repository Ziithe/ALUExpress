import 'package:alu_express/services/Models/order_model.dart';
import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/services/temp_res/order_data.dart';
import 'package:alu_express/ui_screens/shared_widgets/orders_image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AcceptedOrders extends StatefulWidget {
  final userid;
  AcceptedOrders({Key key, @required this.userid}) : super(key: key);
  @override
  _AcceptedOrdersState createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (BuildContext context) =>
          firebaseServices.getAcceptedorderList(widget.userid),
      child: Accepted(),
    );
  }
}

class Accepted extends StatefulWidget {
  @override
  _AcceptedState createState() => _AcceptedState();
}

class _AcceptedState extends State<Accepted> {
  Widget build(BuildContext context) {
    List Acceptedorders = Provider.of<List<OrderModel>>(context);

    return Acceptedorders == null
        ? SpinKitSquareCircle(
            color: Colors.amberAccent,
          )
        : ListView.builder(
            itemCount: Acceptedorders.length,
            itemBuilder: (_, index) {
              if (Acceptedorders[index].orderStatus == "Accepted") {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('Foods');

                return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(Acceptedorders[index].foodID).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Error Food does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      Map<String, dynamic> orderdetails = {
                        "image": data["ImageURL"],
                        "ordernumber": "1",
                        "time": Acceptedorders[index].orderTime,
                        "orderid": Acceptedorders[index].orderID,
                        "state": "Accepted",
                        "quantity": Acceptedorders[index].quantity,
                        "price": data["Price"],
                        "inStock": data["Quantity"],
                        "foodName": data["FoodName"],
                        "studentId": Acceptedorders[index].customerID,
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

                    return Text("loading");
                  },
                );
              }

              return Container();
            });
  }
}
