import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fooddeliveryapp/bloc/provider.dart';
import 'package:fooddeliveryapp/foodItem.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  //stream that recieves a number and changes the count;
  var _listController = BehaviorSubject<List<FoodItem>>.seeded([]);

  CartProvider provider = CartProvider();

  Stream<List<FoodItem>> get listStream => _listController.stream;

  Sink<List<FoodItem>> get listSink => _listController.sink;

//business logic
  addToList(FoodItem foodItem) {
    listSink.add(provider.addToList(foodItem));
  }

  removeFromList(FoodItem foodItem) {
    listSink.add(provider.removeFromList(foodItem));
  }

  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
//dispose will be called automatically by closing its streams

}
