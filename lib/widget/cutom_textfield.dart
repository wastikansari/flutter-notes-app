import 'package:flutter/material.dart';
import 'package:notes_app/widget/custom_text.dart';


class CustomTextField extends StatelessWidget {
  final String text;
  final bool obscureText;
  const CustomTextField({super.key, required this.text,  this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: text, color: Colors.black87, size: 13,),
          const SizedBox(height: 5,),
          TextField(
            obscureText: obscureText,
            decoration:  InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey)
              ),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey)
              ),
            ),
          ),
          
        ],
      ),
    );
  }
  }






