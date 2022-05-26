import 'package:alu_express_student/services/Models/cart_funtionality.dart';
import 'package:alu_express_student/services/Models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final CartFunctionality cartFunctionality = CartFunctionality();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Cart"),
            SizedBox(
              width: 20,
            ),
            Icon(Feather.shopping_cart),
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: 400,
              width: 500,
              child: GridView.builder(
                  
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: cartFunctionality.getOrders().length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(cartFunctionality
                          .getOrders()
                          .toList()[index]
                          .foodName),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[100],
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Total:",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: Colors.red[700])),
                      SizedBox(
                        width: 20,
                      ),
                      Text("RWF 3000",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Place Order"),
                    style: ElevatedButton.styleFrom(primary: Colors.red[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List cartitems = Provider.of<List<CartModel>>(context);

    return cartitems == null
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: cartitems.length,
            itemBuilder: (context, index) {
              Map orderDetails = {
                "image": cartitems[index]['image'],
                'foodName': cartitems[index]['foodName'],
                'vendor': cartitems[index]['vendor'],
                'customer': cartitems[index]['customer'],
                'price': cartitems[index]['total'],
              };
              return Container(
                alignment: Alignment.center,
                child: OrdersCard(
                  productDetails: orderDetails,
                ),
              );
            });
  }
}

class OrdersCard extends StatefulWidget {
  final Map productDetails;

  const OrdersCard({Key key, this.productDetails}) : super(key: key);

  @override
  _OrdersCardState createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Image(
                    width: 70,
                    image: NetworkImage(
                      widget.productDetails['image'],
                    )),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productDetails['foodName'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.productDetails['vendor'],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.productDetails['customer']),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.productDetails['price'],
                        style: TextStyle(color: Colors.red[700])),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(icon: Icon(Feather.x), onPressed: () {})
              ],
            )),
      ),
    );
  }
}






// class Cart extends StatefulWidget {
//   final List<Dish> _cart;

//   Cart(this._cart);

//   @override
//   _CartState createState() => _CartState(this._cart);
// }

// class _CartState extends State<Cart> {
//   _CartState(this._cart);

//   List<Dish> _cart;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//           itemCount: _cart.length,
//           itemBuilder: (context, index) {
//             var item = _cart[index];
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//               child: Card(
//                 elevation: 4.0,
//                 child: ListTile(
//                   leading: Icon(
//                     item.icon,
//                     color: item.color,
//                   ),
//                   title: Text(item.name),
//                   trailing: GestureDetector(
//                       child: Icon(
//                         Icons.remove_circle,
//                         color: Colors.red,
//                       ),
//                       onTap: () {
//                         setState(() {
//                           _cart.remove(item);
//                         });
//                       }),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }