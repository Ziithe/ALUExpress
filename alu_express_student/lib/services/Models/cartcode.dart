import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
Future<void> saveCart(cart) async {
  for (int i = 0; i < cart.length; i++) {
    Map data = {
      "foodName": cart[i]["FoodName"],
      "quantity": cart[i]["Quantity"],
      "total": cart[i]["Total"],
      "vendorID": cart[i]["Vendor"],
      "customerID": cart[i]["Customer"],
      "orderTime": cart[i]["OrderTime"],
      "foodID": cart[i]["FoodID"],
      'category': cart[i]["Category"],
      "orderStatus": cart[i]["OrderStatus"]
    };
    print(
      data,
    );
    Map<String, dynamic> myMap = new Map<String, dynamic>.from(data);
    DocumentReference ref = await firebaseFirestore.collection("orders").add(myMap);
       String docid = ref.id.toString();
    print(docid);
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(docid)
        .update({'orderID': docid});
  }
}

void showCart(context, cart, vendorid) {
  print(cart);

  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(builder: (context, setState) {
          if (cart.length == 0) {
            return AlertDialog(
              title: Text("MyCart"),
              actions: [
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              content: Center(
                child: Text("Nothing in cart"),
              ),
            );
          } else {
            return AlertDialog(
              title: Text("My Cart"),
              actions: [
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Place Order"),
                  onPressed: () {
                    saveCart(cart);
                    print("Order Placed");
                    setState(() {
                      cart = [];
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
              content: Container(
                height: 400,
                width: 300,
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (ctx, i) {
                    String time =
                        "${cart[i]["OrderTime"].year.toString()}-${cart[i]["OrderTime"].month.toString().padLeft(2, '0')}-${cart[i]["OrderTime"].day.toString().padLeft(2, '0')}   ${cart[i]["OrderTime"].hour.toString()}-${cart[i]["OrderTime"].minute.toString()}";
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("x" + cart[i]["Quantity"]),
                        Text(cart[i]["FoodName"]),
                        Text(time),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        });
      });
}
