import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/notes_api.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:notes_app/widget/custom_button.dart';
import 'package:notes_app/widget/custom_text.dart';
import 'package:notes_app/widget/cutom_textfield.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  NotesApi notesApi = NotesApi();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void addNote() async {
    final String title = titleController.text;
    final String description = descriptionController.text;

    if (title.isEmpty) {
      Get.snackbar("Title", "Please enter note title");
    } else if (description.isEmpty) {
      Get.snackbar("Description", "Please enter note description");
    } else {
      await notesApi.addNotes(title, description).then((value) {
        if (value.status == true) {
          print('succesfully add');
          bool isProgrees = false;
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const NotesScreen();
          }), ((route) => false));
        } else {
          bool isProgrees = false;
          Get.snackbar("Add Card", value.message!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 21, 98, 231),
          centerTitle: true,
          title: const CustomText(
            text: 'Add Notes',
            size: 20,
            weight: FontWeight.w500,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLines: null,
                    autofocus: true,
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Title",
                    ),
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Type something...",
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addNote();
          },
          backgroundColor: AppColor.primaryColor,
          label: CustomText(
            text: 'Save',
            weight: FontWeight.w500,
          ),
          icon: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ));
  }
}
