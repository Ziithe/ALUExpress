import 'package:alu_express/ui_screens/homepage_ui/home_page.dart';
import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  final uid;
  final text;
  final successful;

  PopUp({
    @required this.text,
    @required this.successful,
    Key key,
    @required  this.uid,
  }) : super(key: key);
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.text),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              primary: Colors.amber),
          onPressed: () {
            widget.successful
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(userid: widget.uid)))
                : Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}


// DocumentReference(products/25Nf9TPtbQMEgoy6CvE2)