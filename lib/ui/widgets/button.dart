import 'package:flutter/material.dart';
import 'package:taskapp/ui/theme.dart';


class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr
        ),
        child: Text(label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}