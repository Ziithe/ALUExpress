import 'package:alu_express/ui_screens/shared_widgets/menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCard extends StatefulWidget {
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

  const MenuCard(
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
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProduct(
                          image: widget.image,
                          name: widget.name,
                          price: widget.price,
                          category: widget.category,
                          description: widget.description,
                          discount: widget.discount,
                          isFeaured: widget.isFeaured,
                          size: widget.size,
                          ingredients: widget.ingredients,
                          vendor: widget.vendor,
                          documentId: widget.documentId,
                        )));
          },
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          leading: CachedNetworkImage(
            imageUrl: widget.image,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // leading: CircleAvatar(
          //   radius: 50,
          //   backgroundImage: NetworkImage(
          //     widget.image,
          //   ),
          // ),
          title: Text(
            widget.name,
            style: GoogleFonts.ptSans(fontSize: 18, letterSpacing: .3),
          ),
          subtitle: Text(
            "RWF " + widget.price,
            style: GoogleFonts.ptSans(
                color: Colors.red[900], fontSize: 14, letterSpacing: .3),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: Colors.black,
            size: 30.0,
          ),
          isThreeLine: false,
        ),
      ),
    );
  }
}
