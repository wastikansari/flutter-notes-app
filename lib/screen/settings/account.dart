import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/notes_api.dart';
import 'package:notes_app/widget/card.dart';
import 'package:notes_app/widget/custom_text.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
    NotesApi notesApi = NotesApi();
  String name='';
  String email='';
  bool  isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetail();
  }




    void userDetail() async {
    setState(() {
      isLoading = true;
    });
    print('dddddddddd 1 $isLoading');
    await notesApi.getNotesApi().then((value) {
      var msg = value.data![0];
      print(
          'wwwwwwwwwwwwwwww ${value.status} and ${msg}');

      setState(() {
        name = msg.name.toString();
        email = msg.email.toString();
  
        isLoading = false;
      });
      print('dddddddddd 2$isLoading');
    });
    setState(() {
      isLoading = false;
    });

    print('dddddddddd 3 $isLoading');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 21, 98, 231),
        centerTitle: true,
        title: const CustomText(
          text: "Account",
          size: 20,
          weight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              TextCard(
                title: 'User name',
                icon: Icons.person,
                name: name,
              ),
              SizedBox(
                height: 20,
              ),
              TextCard(
                title: 'User Email',
                icon: Icons.email,
                name: email,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
