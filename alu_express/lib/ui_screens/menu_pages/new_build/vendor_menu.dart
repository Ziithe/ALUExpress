import 'package:alu_express/services/Models/services.dart';
import 'package:alu_express/services/Models/vendor_model.dart';
import 'package:alu_express/ui_screens/shared_widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendorMenu extends StatefulWidget {
  final userid;
  VendorMenu({Key key, @required this.userid}) : super(key: key);
  @override
  _VendorMenuState createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100.0, 0, 0, 0),
          child: Text(
            "Your Menu",
            style: GoogleFonts.ptSans(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: .3),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamProvider(
        create: (BuildContext context) =>
            firebaseServices.getFoodList(widget.userid),
        child: ViewUserPage(),
      ),
    );
  }
}

class ViewUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List userList = Provider.of<List<VendorModel>>(context);

    return userList == null
        ? SpinKitSquareCircle(
            color: Colors.amberAccent,
          )
        : ListView.builder(
            itemCount: userList.length,
            itemBuilder: (_, int index) => Padding(
                padding: EdgeInsets.all(10.0),
                child: MenuCard(
                  image: userList[index].imageURL,
                  name: userList[index].foodName,
                  price: userList[index].price,
                  category: userList[index].category,
                  description: userList[index].description,
                  discount: userList[index].discount,
                  isFeaured: userList[index].isFeatured,
                  size: userList[index].size,
                  ingredients: userList[index].ingredients,
                  vendor: userList[index].vendor,
                  documentId: userList[index].documentId,
                )),
          );
  }
}
