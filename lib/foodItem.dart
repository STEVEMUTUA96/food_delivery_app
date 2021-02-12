import 'package:flutter/cupertino.dart';
//foodItemList is object to class FoodItemList
FoodItemList foodItemList = FoodItemList(foodItems:[
  FoodItem(
    id: 1,
    tittle: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: 'assets/images/7.jpg'
  ),
  FoodItem(
      id: 2,
      tittle: "Pached Chips",
      hotel: "Pizza Inn",
      price: 18.49,
      imgUrl: 'assets/images/2.jpg'
  ),
  FoodItem(
      id: 3,
      tittle: "Delicious Meat",
      hotel: "Njunguna's",
      price: 11.99,
      imgUrl: 'assets/images/5.jpg'
  ),
  FoodItem(
      id: 4,
      tittle: "Fried Cooked Meat",
      hotel: "CFC Kenya",
      price: 16.79,
      imgUrl: 'assets/images/4.jpg'
  ),
  FoodItem(
      id: 5,
      tittle: "Fresh Fruits",
      hotel: "Fruit Center",
      price: 24.69,
      imgUrl: 'assets/images/6.jpg'
  ),
]);

class FoodItemList{
  List<FoodItem> foodItems; //List<FoodItem> hold the collection of the items.
  FoodItemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String tittle;
  String hotel;
  double price;
  String imgUrl;
  int quantity;

  FoodItem(
      {@required this.id,
      @required this.tittle,
      @required this.hotel,
      @required this.price,
      @required this.imgUrl,
      this.quantity = 1});

  void incrementQuantity() {
    this.quantity = this.quantity + 1; // this = is instance of class Fooditem
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
