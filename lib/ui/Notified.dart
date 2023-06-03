

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.grey[600]:Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(Icons.arrow_back,
          color: Get.isDarkMode?Colors.white:Colors.grey,
          )
          
          
          ),
          title: Text(this.label.toString().split("|")[0],
          style: TextStyle(color: Colors.black),
          
          
          ),
      ),
      
    );
  }
}