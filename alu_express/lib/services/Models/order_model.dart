class OrderModel {
  String category;
  String customerID;
  String foodID;
  String foodName;
  String orderStatus;
  String orderTime;
  String quantity;
  String total;
  String vendor;
  String orderID;

  OrderModel(
      {this.category,
      this.customerID,
      this.foodID,
      this.foodName,
      this.orderStatus,
      this.orderTime,
      this.quantity,
      this.total,
      this.vendor,
      this.orderID});

  OrderModel.fromJson(Map<String, dynamic> parsedJSON)
      : category = parsedJSON['category'],
        customerID = parsedJSON['customerID'],
        foodID = parsedJSON['foodID'],
        foodName = parsedJSON['foodName'],
        orderStatus = parsedJSON['orderStatus'],
        orderTime = parsedJSON['orderTime'].toString(),
        quantity = parsedJSON['quantity'],
        total = parsedJSON['total'],
        orderID = parsedJSON['orderID'],
        vendor = parsedJSON['vendor'];
}
