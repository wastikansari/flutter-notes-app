import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/api/models/user_model.dart';
import 'package:notes_app/api/notes_api.dart';
import 'package:notes_app/routes/routes.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/edit_note_screen.dart';
import 'package:notes_app/screen/settings/setting.dart';
import 'package:notes_app/widget/circle_image.dart';
import 'package:notes_app/widget/custom_text.dart';
import 'package:notes_app/widget/notes_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  NotesApi notesApi = NotesApi();
  var axisV = 2;

  final lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: const CustomText(
            text: 'My Notes',
            size: 20,
            weight: FontWeight.w500,
          ),
          leading:
              // StatefulBuilder(
              //   builder: (BuildContext context, state) {

              //     return
              IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
            // icon: Icon(axisV == 2 ? Icons.list : Icons.grid_on),
          ),
          //   }
          // ),

          // CustomIconBtn(
          //                 color: Theme.of(context).backgroundColor,
          //                 onPressed: () {
          //                   authController.axisCount.value = authController.axisCount.value == 2 ? 4 : 2;
          //                 },
          //                 icon: Icon(authController.axisCount.value == 2
          //                     ? Icons.list
          //                     : Icons.grid_on),
          //               ),,
          actions: [
                       IconButton(
              onPressed: ()  {
                // print('Logout');

                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // print(
                //     ' isn ${prefs.remove('token')} and ${prefs.remove('token')}');
                // prefs.remove('token');
                // prefs.remove('tokentypof');
                  Navigator.push(  
    context,  
    MaterialPageRoute(builder: (context) => SettingScreen()),  
  );  

               

              },
              icon: const Icon(Icons.settings),
            )

            // IconButton(
            //   onPressed: () async {
            //     print('Logout');

            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     print(
            //         ' isn ${prefs.remove('token')} and ${prefs.remove('token')}');
            //     prefs.remove('token');
            //     prefs.remove('tokentypof');

            //     Get.offAllNamed(Routes.introScreen);
            //   },
            //   icon: const Icon(Icons.logout),
            // )
          ],
        ),
        body: RefreshIndicator(
          color: AppColor.primaryColor,
          backgroundColor: Colors.white,
          onRefresh: notesApi.getNotesApi,
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: FutureBuilder<UserModel>(
              future: notesApi.getNotesApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.data![0].notes!.length == 0
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/notes1.json',
                              width: 250,
                              height: 250,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Quickly capture your thoughts!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 174, 174, 174),
                                  fontSize: 13),
                            ),
                              SizedBox(
                              height: 50,
                            ),
                          ],
                        ))
                      : StaggeredGridView.countBuilder(
                          itemCount: snapshot.data!.data![0].notes!.length,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemBuilder: (context, index) {
                            var notes = snapshot.data!.data![0].notes![index];
                            var ti = notes.createdAt!.split('T')[0];
                            print('ddddddddddddddd $ti');
                            var formattedDate =
                                DateFormat.yMMMd().format(DateTime.parse(ti));
                            print('ddddddddddddddd $formattedDate');
                            Random random = new Random();
                            Color bg = lightColors[random.nextInt(8)];
                            return GestureDetector(
                              onTap: () {
                                var cardId =
                                    snapshot.data!.data![0].notes![index].sId;
                                print('tap $index and $cardId');
                                bottomSheetPage(context, cardId, index);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: bg,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.only(
                                        top: 5,
                                        right: 8,
                                        left: 8,
                                        bottom: 0,
                                      ),
                                      title: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          notes.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        notes.message!,
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                  // ListView.builder(
                  //     itemCount: snapshot.data!.data![0].notes!.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       var notes = snapshot.data!.data![0].notes![index];

                  //       return Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 12, right: 12, top: 10),
                  //           child: InkWell(
                  //             onTap: () {
                  //               var cardId =
                  //                   snapshot.data!.data![0].notes![index].sId;
                  //               print('tap $index and $cardId');
                  //               bottomSheetPage(context, cardId, index);
                  //             },
                  //             child: NoteCard(
                  //               title: notes.title!,
                  //               dec: notes.message!,
                  //               time: notes.createdAt!.split('T')[0],
                  //             ),
                  //           ));
                  //     });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _addNotes();
          },
          backgroundColor: AppColor.primaryColor,
          label: CustomText(text: 'Add Notes'),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }

  void _addNotes() {
    Get.toNamed(Routes.addNoteScreen);
  }

  void bottomSheetPage(BuildContext context, cardId, index) {
    final String _cardId = cardId;
    showModalBottomSheet(
        elevation: 15,
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  width: 45,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 128, 128, 128),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleBox(
                          title: 'Edit',
                          tooltip: 'Note edit',
                          icon: Icon(
                            Icons.edit,
                            color: AppColor.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _editCard(index);
                          }),
                      const SizedBox(
                        width: 55,
                      ),
                      CircleBox(
                          title: 'Delete',
                          tooltip: 'Note delete',
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteCard(_cardId);
                          }),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _editCard(index) {
    print('edit tap');
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return EditNoteScreen(id: index);
    }));
  }

  void _deleteCard(_cardId) {
    final cardId = _cardId;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete?'),
            content: const Text('Are you sure you want to delete this notes ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const CustomText(
                    text: 'Cancle',
                    size: 15,
                    color: Colors.blue,
                    weight: FontWeight.w400,
                  )),
              TextButton(
                  onPressed: () async {
                    notesApi.deleteNotes(cardId).then((value) {
                      if (value.status == true) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NotesScreen();
                        }), ((route) => false));
                      } else {
                        Get.snackbar("Link Card", "Link card deleted fail");
                        Navigator.pop(context);
                        print('back ddd');
                      }
                    });
                  },
                  child: CustomText(
                    text: 'Delete',
                    size: 15,
                    color: Colors.red,
                    weight: FontWeight.w400,
                  )),
            ],
          );
        });
  }
}
