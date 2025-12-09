import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/HomeController.dart';

class MyList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // This widget is simplified since the new controller doesn't have dataList
    // You can customize this to show a list of cities or forecast items
    return SizedBox(
      height: 150,
      child: Center(
        child: Text(
          'City List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
            fontFamily: 'flutterfonts',
          ),
        ),
      ),
    );
  }
}