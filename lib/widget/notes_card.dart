import 'package:flutter/material.dart';
import 'package:notes_app/widget/custom_text.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String dec;
  final String time;
  final Color color;
  const NoteCard(
      {super.key,
      required this.title,
      required this.dec,
      required this.time,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 28, 28, 28),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 12, top: 16, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              size: 18,
              color: const Color.fromARGB(239, 255, 253, 253),
              weight: FontWeight.w500,
            ),
            const SizedBox(
              height: 5,
            ),
            CustomText(
              text: dec,
              size: 13,
              color: Colors.grey,
              weight: FontWeight.w400,
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomText(
                text: time,
                size: 11,
                color: Colors.grey,
                weight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
