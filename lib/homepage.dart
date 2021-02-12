import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/bloc/cart.dart';
import 'package:fooddeliveryapp/bloc/cartListBloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fooddeliveryapp/foodItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [Bloc((i) => CartListBloc())],
        child: MaterialApp(
          title: "Food Delivery",
          home: MyHome(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),
              SizedBox(height: 45),
              for (var foodItem in foodItemList.foodItems)
                ItemContainer(foodItem: foodItem)
            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  ItemContainer({this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);

        final snackbar = SnackBar(
          content: Text("${foodItem.tittle} added to the cart"),
          duration: Duration(milliseconds: 550),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Items(
          hotel: foodItem.hotel,
          itemName: foodItem.tittle,
          itemPrice: foodItem.price,
          imgUrl: foodItem.imgUrl,
          leftAligned: (foodItem.id % 2 == 0) ? true : false),
    );
  }
}

class Items extends StatelessWidget {
  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Text("\$$itemPrice",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15
                            ),
                            children: [
                              TextSpan(text: "by"),
                              TextSpan(
                                  text: hotel,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding,)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Items({@required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel});
}

class FirstHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          searchBar(),
          SizedBox(height: 30),
          categories(),
        ],
      ),
    );
  }

  Widget categories() {
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          categoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availabity: 12,
            selected: true,
          ),
          categoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Chips",
            availabity: 12,
            selected: false,
          ),
          categoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Meat",
            availabity: 12,
            selected: false,
          ),
          categoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Fruits",
            availabity: 12,
            selected: false,
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search...",
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintStyle: TextStyle(color: Colors.black87)),
          ),
        )
      ],
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 45),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Food",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            Text(
              "Delivery",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;

              int lenght = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(lenght, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int lenght, BuildContext context,List<FoodItem> foodItems){
    return GestureDetector(
      onTap: (){
       if(lenght>0){
         Navigator.push(
             context,MaterialPageRoute(builder: (context) => Cart()));
       }else{
         return;
       }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(lenght.toString()),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.yellow[800],borderRadius: BorderRadius.circular((50)),
        ),
    ),
    );
  }

}

class categoryListItem extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;
  final availabity;
  final bool selected;

  categoryListItem({@required this.categoryIcon,
    @required this.categoryName,
    @required this.availabity,
    @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected ? Color(0xfffeb324) : Colors.white,
          border: Border.all(
              color: selected ? Colors.transparent : Colors.grey[200],
              width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100],
                blurRadius: 15,
                offset: Offset(25, 0),
                spreadRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey,
                    width: 1.5)),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            categoryName,
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 1.5,
            color: Colors.black12,
          ),
          Text(
            availabity.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          )
        ],
      ),
    );
  }
}
