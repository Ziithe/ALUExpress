import 'package:alu_express_student/services/Models/firebase_services.dart';
import 'package:alu_express_student/services/Models/food_model.dart';
import 'package:alu_express_student/services/Models/cartcode.dart';
import 'package:alu_express_student/ui_screens/homepage_ui/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alu_express_student/ui_screens/shared_widgets/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:alu_express_student/services/Models/cart_funtionality.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeProducts extends StatefulWidget {
  final userid;
  const HomeProducts({Key key, this.userid}) : super(key: key);
  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  List cartItems = [];
  final dateTime = DateTime.now();
  final List cart = [];
  int total = 0;
  final CartFunctionality cartFunctionality = CartFunctionality();

  Widget build(BuildContext context) {
    void showCart(context) {
      print(cart);

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(
                    "My Cart",
                    style: GoogleFonts.ptSans(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .3),
                  ),
                  actions: [
                    new ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: new Text("Close",
                          style: GoogleFonts.ptSans(
                              fontSize: 16, color: Colors.black)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child: new Text(
                        "Place Order",
                        style: GoogleFonts.ptSans(
                            fontSize: 16, color: Colors.black),
                      ),
                      onPressed: () {
                        saveCart(cart);
                        print("Order Placed!");
                        setState(() {
                          cart.clear();
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
              },
            );
          });
    }

    void showProductDetails(Map productDetails) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            int _quantity = 1;
            int price = int.parse(productDetails["Price"]);
            total = price;
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
                totals = price * quantity;
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

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: productDetails["productName"],
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          primary: Colors.amber),
                      child: new Text(
                        "Close",
                        style: GoogleFonts.ptSans(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          primary: Colors.red[900]),
                      child: new Text(
                        "Add to Cart",
                        style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () {
                        createitem(cart, total, _quantity, productDetails);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        productDetails["Name"],
                        style: GoogleFonts.ptSans(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: .3),
                      ),
                      Text(
                        "Description: " + productDetails["Description"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: .3),
                      ),
                      CachedNetworkImage(
                        height: displayHeight(context) * 0.2,
                        imageUrl: productDetails["Image"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                SpinKitRotatingCircle(
                          color: Colors.amberAccent,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "RWF " + (total).toString(),
                            style: GoogleFonts.ptSans(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: .3),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12)),
                            child: IconButton(
                                icon: Icon(LineIcons.minus),
                                onPressed: () {
                                  setState(() {
                                    _decrementOrder();
                                  });
                                }),
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
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12)),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _incrementOrder();
                                });
                              },
                              icon: Icon(Feather.plus),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          });
    }

    return Scaffold(
      drawer: Drawer(
        child: DrawerProvider(userid: widget.userid),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.sort_rounded, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: <Widget>[
          Stack(children: <Widget>[
            new IconButton(
                icon: new Icon(
                  LineIcons.shoppingCart,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  showCart(context);
                }),
            cart.length == 0
                ? new Container()
                : new Positioned(
                    child: new Stack(
                    children: <Widget>[
                      new Icon(Icons.brightness_1,
                          size: 20.0, color: Colors.red[800]),
                      new Positioned(
                          top: 3.0,
                          right: 4.0,
                          child: new Center(
                            child: new Text(
                              cart.length.toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  )),
          ]),
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: displayHeight(context) * 0.03,
            left: displayWidth(context) * 0.03,
            right: displayWidth(context) * 0.03,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: displayWidth(context) * 0.7,
                  child: Text(
                    "Order your favourite meals below",
                    style: GoogleFonts.ptSans(
                        fontSize: 25,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        letterSpacing: .3),
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Click on a product to view the full details",
                  style: GoogleFonts.ptSans(
                      fontSize: 18, color: Colors.black54, letterSpacing: .3),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              SingleChildScrollView(
                child: StreamProvider(
                  create: (BuildContext context) =>
                      firebaseServices.getFoodList(),
                  child: ViewUserPage(showProductDetails),
                ),
              )
            ],
          )),
    );
  }
}

class ViewUserPage extends StatelessWidget {
  ViewUserPage(this.showDialog);
  final Function showDialog;
  @override
  Widget build(BuildContext context) {
    List userList = Provider.of<List<FoodModel>>(context);

    return userList == null
        ? SpinKitSquareCircle(color: Colors.amberAccent)
        : GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: userList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                child: ProductCard(
                  showDialog: showDialog,
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
                  foodid: userList[index].foodid,
                  timeuploaded: userList[index].timeuploaded,
                  quantity: userList[index].quantity,
                  indexs: index,
                ),
              );
            });
  }
}

class ProductCard extends StatefulWidget {
  final Function showDialog;
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

  const ProductCard(
      {Key key,
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
      this.showDialog})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return GestureDetector(
      onTap: () {
        Map productDetails = {
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
        widget.showDialog(productDetails);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 5)),
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: displayWidth(context) * 0.4,
            height: displayHeight(context) * 0.15,
            imageUrl: widget.image,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SpinKitRotatingCircle(
              color: Colors.amber,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30)),
            width: displayWidth(context) * 0.4,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(widget.name,
                    style: GoogleFonts.ptSans(
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                      letterSpacing: .3,
                      fontSize: 18,
                    )),
                Text('RWF ' + widget.price,
                    style: GoogleFonts.ptSans(
                      color: Colors.black,
                      fontSize: 16,
                    )),
                // Text(widget.description)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
