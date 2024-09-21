import 'package:flutter/material.dart';
import 'package:notify/main.dart';
import 'package:notify/models/data.dart';
import 'package:notify/models/notes_data.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() {
    return _AddNotePageState();
  }
}

String noteText = "";
bool noteImportance = false;

class _AddNotePageState extends State<AddNotePage> {
  void changeNewNoteText(String changedText) {
    setState(() {
      noteText = changedText;
    });
  }

  void changeNewNoteImportance() {
    setState(() {
      if (noteImportance) {
        noteImportance = false;
      } else {
        noteImportance = true;
      }
    });
  }

  void createNote() {
    setState(() {
      NoteInterface.createNote(noteText, noteImportance);
      noteText = "";
      noteImportance = false;
      Navigator.of(context).pop(AddNoteRoute(child: const AddNotePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: NotifyColors.themeBackgroundColor,
        body: Column(
          children: [
            Container(
                height: 100,
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                color: NotifyColors.themeBackgroundColor,
                child: const Center(
                    child: Text(
                  "Edit Note",
                  style: TextStyle(
                      fontFamily: "MakerMono",
                      color: NotifyColors.themeTextColor,
                      fontSize: 40),
                ))),
            Container(
                color: Colors.transparent,
                height: 140,
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                child: Center(
                  child: SizedBox(
                    height: 100,
                    width: 180,
                    child: Card(
                        elevation: 18,
                        shape: const BeveledRectangleBorder(
                          side: BorderSide(
                            color: NotifyColors.themeTwo,
                            width: 4,
                          ),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(30)),
                        ),
                        color: NotifyColors.themeTwo,
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    noteText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "MakerMono",
                                        fontSize: 11),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Visibility(
                                      visible: noteImportance,
                                      child: const Icon(
                                        Icons.star_rounded,
                                        color: NotifyColors.notifLightYellow,
                                        size: Consts.noteIconSize,
                                      )),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                )),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Container(
                    height: 120,
                    constraints:
                        const BoxConstraints(minWidth: 200, maxWidth: 500),
                    child: Center(
                        child: Container(
                      height: 75,
                      width: 300,
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        onChanged: (String text) {
                          changeNewNoteText(text);
                        },
                        maxLength: 40,
                        style: const TextStyle(
                          color: NotifyColors.themeTwo,
                          fontFamily: "MakerMono",
                          fontSize: 12,
                          height: 2,
                        ),
                        cursorColor: NotifyColors.themeTwo,
                        decoration: const InputDecoration(
                            counterText: "",
                            focusColor: Colors.transparent,
                            labelText: "Note Text:",
                            labelStyle: TextStyle(
                                fontFamily: "MakerMono",
                                fontSize: 12,
                                color: NotifyColors.themeTwo),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: NotifyColors.themeTwo,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: NotifyColors.themeTwo,
                                width: 3.3,
                              ),
                            )),
                      ),
                    )))
              ],
            ))),
            Container(
                color: NotifyColors.themeBackgroundColor,
                height: 100,
                alignment: Alignment.bottomCenter,
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                child: Stack(
                  children: [
                    Positioned(
                      left: 25,
                      top: 30,
                      bottom: 30,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pop(AddNoteRoute(child: const AddNotePage())),
                        child: Container(
                          color: NotifyColors.themeTextColor,
                          width: 90,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Back",
                              style: TextStyle(fontFamily: "MakerMono"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 25,
                      top: 30,
                      bottom: 30,
                      child: GestureDetector(
                        onTap: createNote,
                        child: Container(
                          color: NotifyColors.themeTextColor,
                          width: 90,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Create",
                              style: TextStyle(fontFamily: "MakerMono"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
