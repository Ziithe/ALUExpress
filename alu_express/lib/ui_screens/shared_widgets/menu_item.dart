import 'package:alu_express/ui_screens/shared_widgets/menu_edit_pop_up.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProduct extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String category;
  final String description;
  final String discount;
  final String isFeaured;
  final String size;
  final String ingredients;
  final String vendor;
  final String documentId;

  const EditProduct(
      {Key key,
      @required this.image,
      @required this.name,
      @required this.price,
      @required this.category,
      @required this.description,
      @required this.discount,
      @required this.isFeaured,
      @required this.size,
      @required this.ingredients,
      @required this.vendor,
      @required this.documentId})
      : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Product information",
                          style: GoogleFonts.ptSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .3),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "Food ID ",
                          style: GoogleFonts.ptSans(
                              fontSize: 18, letterSpacing: .3),
                        ),
                        leading: Icon(Icons.food_bank),
                        subtitle: Text(widget.vendor),
                      ),
                      ListTile(
                        title: Text("Name",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        leading: Icon(Icons.food_bank),
                        subtitle: Text(widget.name),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.name,
                                      field: "FoodName",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Price",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        leading: Icon(Icons.money),
                        subtitle: Text(widget.price),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.price,
                                      field: "Price",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Discount",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        subtitle: Text(widget.discount),
                        leading: Icon(Icons.money_off),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.discount,
                                      field: "Discount",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Size",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        subtitle: Text(widget.size),
                        leading: Icon(Icons.zoom_in),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.size,
                                      field: "Size",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Category",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        subtitle: Text(widget.category),
                        leading: Icon(Icons.category),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.category,
                                      current: widget.name,
                                      field: "Category",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Description",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        subtitle: Text(widget.description),
                        leading: Icon(Icons.description),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.description,
                                      field: "Description",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text("Ingredients",
                            style: GoogleFonts.ptSans(
                                fontSize: 18, letterSpacing: .3)),
                        subtitle: Text(widget.ingredients),
                        leading: Icon(Icons.line_style_outlined),
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    MenuEditPopUp(
                                      docId: widget.documentId,
                                      current: widget.ingredients,
                                      field: "Ingredients",
                                    ));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ])));
  }
}
