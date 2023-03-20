import 'package:flutter/material.dart';
import 'package:notes_app/widget/custom_text.dart';

class TextCard extends StatelessWidget {
  final String title;
  final String name;
  final IconData icon;
  const TextCard(
      {super.key, required this.title, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          size: 17,
          weight: FontWeight.w500,
          color: Color.fromARGB(255, 41, 41, 41),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 243, 243),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 21,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: name,
                  size: 16,
                   weight: FontWeight.w500,
                   color: Color.fromARGB(228, 59, 59, 59),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}