import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  

  const CustomButton({super.key, required this.text, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 55,
      color: const Color.fromARGB(255, 21, 98, 231),
      onPressed: () {
        onPressed();
      },
      shape: RoundedRectangleBorder(
          // side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(13)),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
      ),
    );
  }
}
