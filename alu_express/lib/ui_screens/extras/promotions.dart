import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Promotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Feather.chevron_left,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(90.0, 0, 0, 0),
          child: Text(
            "Home",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "PTSans",
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              "AXpress",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Satisfy",
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("Coming Soon"),
      ),
    );
  }
}
