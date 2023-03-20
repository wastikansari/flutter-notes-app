import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const CustomText({super.key, required this.text,  this.size = 12, this.weight = FontWeight.normal, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text, 
     maxLines: 1,
     overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color

      ),);
  }
}