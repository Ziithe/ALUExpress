
class FoodModel {
  String foodName;
  String description;
  String discount;
  String imageURL;
  String ingredients;
  String isFeatured;
  String price;
  String size;
  String category;
  String vendor;
  String foodid;
  String timeuploaded;
  String quantity;
  FoodModel(
      {this.foodName,
      this.description,
      this.discount,
      this.imageURL,
      this.ingredients,
      this.isFeatured,
      this.price,
      this.size,
      this.category,
      this.vendor,
      this.foodid,
      this.timeuploaded,
      this.quantity}
      );

  FoodModel.fromJson(Map<String, dynamic> parsedJSON)
      : foodName = parsedJSON['FoodName'],
        description = parsedJSON['Description'],
        discount = parsedJSON['Discount'],
        imageURL = parsedJSON['ImageURL'],
        ingredients = parsedJSON['Ingredients'],
        isFeatured = parsedJSON['IsFeatured'],
        price = parsedJSON['Price'],
        size = parsedJSON['Size'],
        category = parsedJSON['Category'],
        vendor = parsedJSON['Vendor'],
        foodid = parsedJSON['DocumentId'],
        timeuploaded = parsedJSON['Timedate'],
        quantity = parsedJSON['Quantity'];
}
