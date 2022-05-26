import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  final String textItem;
  final userData;
  final iconData;

  const CardItem({Key key, this.textItem, this.userData, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 21.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                iconData,
                SizedBox(width: displayWidth(context) * 0.06),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      textItem,
                      style: GoogleFonts.ptSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .3),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      userData,
                      style: GoogleFonts.ptSans(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
