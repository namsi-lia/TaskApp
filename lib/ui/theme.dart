import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color navyBlueBar =Color.fromARGB(255, 4, 14, 121);
Color white =Colors.white;
Color darkHeader=const Color(0xFF263238);
Color darkGreyClr =const Color(0xFF121212);
Color indigoish =const Color(0xFF7986CB);
const primaryClr =Color.fromARGB(255, 4, 14, 121);
Color pinkish =Colors.pink.shade600;
Color purplish =Colors.purple.shade900;



class Themes{
  static final  light=ThemeData(
    backgroundColor: Colors.white,
    primaryColor:primaryClr,
    brightness: Brightness.light
  );
    static final  dark= ThemeData(
      backgroundColor: darkGreyClr,
        primaryColor: darkGreyClr,
        brightness: Brightness.dark
      );
     
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle:TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black
    )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle:TextStyle(
      fontSize:16 ,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.white:Colors.black
    )
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle:TextStyle(
      fontSize:14 ,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[400]
    )
  );
}