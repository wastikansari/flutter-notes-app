import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/notes_api.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:notes_app/widget/custom_text.dart';

class EditNoteScreen extends StatefulWidget {
  final int id;
  const EditNoteScreen({super.key, required this.id});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  NotesApi notesApi = NotesApi();
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String noteId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesDetail();
  }

  void notesDetail() async {
    setState(() {
      isLoading = true;
    });
    print('dddddddddd 1 $isLoading');
    await notesApi.getNotesApi().then((value) {
      var data = value.data![0].notes![widget.id];
      print('wwwwwwwwwwwwwwww ${data}');
      setState(() {
        titleController.text = data.title!;
        descriptionController.text = data.message!;
        noteId = data.sId!;
      });
      print('dddddddddd 2$isLoading');
    });
    setState(() {
      isLoading = false;
    });
    print('dddddddddd 3 $isLoading');
  }

  Future<void> editeNote() async {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String Id = noteId;

    if (title.isEmpty) {
      Get.snackbar("Title", "Please enter note title");
    } else if (description.isEmpty) {
      Get.snackbar("Description", "Please enter note description");
    } else {
      await notesApi.updateNotes(title, description, Id).then((value) {
        if (value.status == true) {
          print('succesfully update');
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const NotesScreen();
          }), ((route) => false));
        } else {
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
            text: 'Edit Notes',
            size: 20,
            weight: FontWeight.w500,
          ),
        ),
        body:   isLoading == true
            ? const Center(child: CircularProgressIndicator())
            :
        
        
        Padding(
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
            editeNote();
          },
          backgroundColor: AppColor.primaryColor,
          label: CustomText(
            text: 'Edit',
            weight: FontWeight.w500,
          ),
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ));
  }
}
