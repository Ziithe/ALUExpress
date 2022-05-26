import 'package:alu_express_student/services/Models/cart_funtionality.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductCard extends StatefulWidget {
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
  final String foodid;
  final String timeuploaded;
  final String quantity;
  final int indexs;

  const ProductCard({
    Key key,
    this.image,
    this.name,
    this.price,
    this.category,
    this.description,
    this.discount,
    this.isFeaured,
    this.size,
    this.ingredients,
    this.vendor,
    this.foodid,
    this.timeuploaded,
    this.quantity,
    this.indexs,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  int _quantity = 1;
  final dateTime = DateTime.now();
  final List cart = [];
  int total = 0;
  Map productDetails;
  int price;
  final CartFunctionality cartFunctionality = CartFunctionality();

  void _incrementOrder() {
    setState(() {
      _quantity++;
      total = price * _quantity;
      print(total);
    });
  }

  void _decrementOrder() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        total = price * _quantity;
        print(total);
      }
    });
  }

  void createitem(cart, totals, quantity, product) {
    setState(() {
      totals = totals * quantity;
    });
    Map item = {
      "FoodName": product["Name"],
      "Quantity": quantity.toString(),
      "Total": totals.toString(),
      "Vendor": product["Vendor"],
      "Customer": product["Userid"],
      "OrderTime": dateTime,
      "FoodID": product["FoodID"],
      'Category': product['Category'],
      "OrderStatus": "Pending",
    };
    cart.add(item);
    cartFunctionality.addToCart(item);
    print(cart);
  }

  @override
  void initState() {
    super.initState();
    _quantity = 1;

    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("taped");
        setState(() {
          productDetails = {
            "Image": widget.image,
            "Name": widget.name,
            "Price": widget.price,
            "Description": widget.description,
            "Ingredients": widget.ingredients,
            "Vendor": widget.vendor,
            "Userid": auth.currentUser.uid,
            "Category": widget.category,
            "Discount": widget.discount,
            "Size": widget.size,
            "FoodID": widget.foodid,
            "timeuploaded": widget.timeuploaded,
            'index': widget.indexs
          };
          total = int.parse(widget.price);

          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, updateState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        productDetails["Name"],
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .3),
                      ),
                      Text(
                        productDetails["Description"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            letterSpacing: .3),
                      ),
                      CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: productDetails["Image"],
                        height: displayHeight(context) * 0.2,
                        width: displayWidth(context) * 0.1,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // Image(
                      //   image: NetworkImage(productDetails["Image"]),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            (total * _quantity).toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .3),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              icon: Icon(Feather.minus),
                              onPressed: () {
                                updateminus(updateState);
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                '$_quantity',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .3),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: () {
                                updatedplus(updateState);
                              },
                              icon: Icon(Feather.plus),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
              });
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 5)),
          CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: widget.image,
            width: displayWidth(context) * 0.4,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // Image(
          //   width: displayWidth(context) * 0.4,
          //   image: NetworkImage(widget.image),
          // ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30)),
            width: displayWidth(context) * 0.4,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'RWF ' + widget.price,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                // Text(widget.description)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> updatedplus(StateSetter updateState) async {
    updateState(() {
      _quantity++;
      total = _quantity * price;
      print(total);
    });
  }

  Future<Null> updateminus(StateSetter updateState) async {
    updateState(() {
      if (_quantity > 1) {
        _quantity--;
        total = price * _quantity;
        print(total);
      }
    });
  }
}
