import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/notes_api.dart';
import 'package:notes_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NotesApi notesApi = NotesApi();
    notesApi.getNotesApi();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      getPages: RouteHelper.routes,
    );
  }
}
