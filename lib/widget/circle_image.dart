import 'package:flutter/material.dart';

class CircleBox extends StatelessWidget {
  final String title;
  final String tooltip;
  final Widget icon;
  final Function onPressed;
  final Color borderColor;
  const CircleBox(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      required this.tooltip,
      this.borderColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              //  color: color,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              icon: icon,
              tooltip: tooltip,
              onPressed: () {
                onPressed();
              }),
          // Center(child: Icon(Icons.camera_alt_outlined)),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}