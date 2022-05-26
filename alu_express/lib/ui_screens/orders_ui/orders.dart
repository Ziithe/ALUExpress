import 'package:alu_express/ui_screens/orders_ui/accepted_item.dart';
import 'package:alu_express/ui_screens/orders_ui/completed.dart';
import 'package:alu_express/ui_screens/orders_ui/pending.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
    final userid;
  Orders({Key key, @required this.userid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.red[900],
            indicatorColor: Colors.red[900],
            labelStyle: TextStyle(color: Colors.red[900], fontFamily: 'PTSans'),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: "Pending",
              ),
              Tab(text: "Accepted"),
              Tab(text: "Completed"),
            ],
          ),
          title: Center(
              child: Text(
            'Orders',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                fontFamily: "PTSans"),
          )),
        ),
        body: TabBarView(
          children: [
            PendingOrders(userid: userid,),
            AcceptedOrders(userid: userid,),
            CompletedOrders(userid: userid,),
          ],
        ),
      ),
    );
  }
}
