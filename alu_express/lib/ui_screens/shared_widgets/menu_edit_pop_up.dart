import 'package:alu_express/services/Models/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuEditPopUp extends StatefulWidget {
  final docId;
  final current;
  final field;

  MenuEditPopUp({
    @required this.docId,
    @required this.current,
    Key key,
   @required  this.field,
  }) : super(key: key);
  @override
  _MenuEditPopUpState createState() => _MenuEditPopUpState();
}

class _MenuEditPopUpState extends State<MenuEditPopUp> {
  TextEditingController toUpdate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final servicesinstance = FirebaseServices();
  String title = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [Text('Update '), Text(widget.field), Text(" ?")],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextFormField(
                controller: toUpdate,
                style: GoogleFonts.ptSans(
                  color: Colors.black,
                  fontSize: 18,
                  letterSpacing: .3,
                ),
                decoration: InputDecoration(
                  hintText: widget.current,
                  hintStyle: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              primary: Colors.red[900]),
          onPressed: () {
            print(toUpdate.text);
            servicesinstance
                .updateField(widget.docId, toUpdate.text, widget.field, 'Foods' )
                .then((value) => {
                      if (value == 'true')
                        {Navigator.of(context).pop()}
                      else
                        {
                          print(value),
                          setState(() {
                            title = value;
                          })
                        }
                    });
          },
          child: Center(child: Text('Update')),
        ),
      ],
    );
  }
}


// DocumentReference(products/25Nf9TPtbQMEgoy6CvE2)