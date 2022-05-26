class CartModel {
  String foodName;
  String total;
  String vendor;
  String category;
  String customer;
  String orderTime;
  String foodID;
  String orderStatus;
  String image;

  CartModel({
    this.foodName,
    this.category,
    this.vendor,
    this.customer,
    this.foodID,
    this.orderStatus,
    this.orderTime,
    this.total,
    this.image,
  });
  CartModel.fromJson(Map<String, dynamic> parsedJSON)
      : foodName = parsedJSON['FoodName'],
        category = parsedJSON['Category'],
        vendor = parsedJSON['Vendor'],
        customer = parsedJSON['Vendor'],
        foodID = parsedJSON['Vendor'],
        orderStatus = parsedJSON['Vendor'],
        orderTime = parsedJSON['Vendor'],
        total = parsedJSON['Vendor'],
        image = parsedJSON['Image'];
}
