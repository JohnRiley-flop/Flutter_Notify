import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notify/add_note.dart';

import 'package:notify/models/data.dart';
import 'package:notify/models/notes_data.dart';
import 'package:notify/sound.dart';

class Consts {
  static const double gridSpacing = 16;
  static const double noteIconSize = 25;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class AddNoteRoute extends PageRouteBuilder {
  final Widget child;

  AddNoteRoute({
    required this.child,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 250),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.elasticInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

class _HomePageState extends State<HomePage> {
  List<Note> myList = NoteInterface.get();

  void refreshPage() {
    setState(() {
      myList = NoteInterface.get();
    });
  }

  Widget buildNote(Note inputNote) {
    var noteUI = DragTarget<Note>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return LongPressDraggable(
            delay: const Duration(milliseconds: 700),
            data: inputNote,
            childWhenDragging: Card(
              elevation: 0,
              shape: const BeveledRectangleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
              ),
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(7),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        inputNote.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.transparent,
                            fontFamily: "MakerMono",
                            fontSize: 11),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Visibility(
                        visible: inputNote.important,
                        child:
                            Stack(alignment: Alignment.center, children: const [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.transparent,
                            size: Consts.noteIconSize,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.transparent,
                            size: Consts.noteIconSize - 7,
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            feedback: Card(
                elevation: 50,
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: inputNote.getSelectedColor(),
                    width: 3,
                  ),
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(25)),
                ),
                color: NotifyColors.themeTwo,
                child: GestureDetector(
                  child: Container(
                    width: 185,
                    height: 105,
                    padding: const EdgeInsets.all(7),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            inputNote.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: NotifyColors.themeAltTextColor,
                                fontFamily: "MakerMono",
                                fontSize: 11),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Visibility(
                            visible: inputNote.important,
                            child: Stack(
                                alignment: Alignment.center,
                                children: const [
                                  Icon(
                                    Icons.star_rounded,
                                    color: NotifyColors.notifBlack,
                                    size: Consts.noteIconSize,
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: NotifyColors.notifLightYellow,
                                    size: Consts.noteIconSize - 7,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            onDragStarted: () {
              //add a little sound here :)
            },
            onDragEnd: ((details) {
              refreshPage();
            }),
            child: Card(
                elevation: 25,
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: inputNote.getSelectedColor(),
                    width: 2,
                  ),
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(25)),
                ),
                color: NotifyColors.themeTwo,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            inputNote.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: NotifyColors.themeAltTextColor,
                                fontFamily: "MakerMono",
                                fontSize: 11),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Visibility(
                            visible: inputNote.important,
                            child: Stack(
                                alignment: Alignment.center,
                                children: const [
                                  Icon(
                                    Icons.star_rounded,
                                    color: NotifyColors.notifBlack,
                                    size: Consts.noteIconSize,
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: NotifyColors.notifLightYellow,
                                    size: Consts.noteIconSize - 7,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        },
        onWillAccept: (data) {
          setState(() {
            inputNote.selected = true;
          });
          return true;
        },
        onLeave: (data) => {
              setState((() {
                inputNote.selected = false;
              }))
            },
        onAccept: (Note data) {
          setState(() {
            data.selected = false;
            inputNote.selected = false;
            if (data != inputNote) {
              NoteInterface.swapNotes(data, inputNote);
            }
          });
        });
    return noteUI;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SoundPlayer media = SoundPlayer();
    media.init();
    return Scaffold(
        backgroundColor: NotifyColors.themeBackgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 180,
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                color: NotifyColors.themeBackgroundColor,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        color: NotifyColors.themeAltBackgroundColor,
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                            child: const Icon(
                          Icons.menu,
                          size: 30,
                          color: NotifyColors.themeAltTextColor,
                        )),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 100,
                      bottom: 30,
                      child: GestureDetector(
                        onTap: (() {
                          //does nothing yet
                        }),
                        child: Container(
                          color: NotifyColors.themeAltBackgroundColor,
                          width: 90,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Pick",
                              style: TextStyle(fontFamily: "MakerMono"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 100,
                      bottom: 30,
                      child: GestureDetector(
                        onTap: () {
                          media.play(1);
                          Navigator.of(context)
                              .push(AddNoteRoute(child: const AddNotePage()))
                              .then((value) {
                            refreshPage();
                          });
                        },
                        child: Container(
                          color: NotifyColors.themeAltBackgroundColor,
                          width: 90,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Add",
                              style: TextStyle(fontFamily: "MakerMono"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Consts.gridSpacing),
                  color: Colors.transparent,
                  height: 100,
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 500,
                  ),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                        overscroll: false,
                        physics: const BouncingScrollPhysics()),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: Consts.gridSpacing,
                              mainAxisSpacing: Consts.gridSpacing,
                              mainAxisExtent: 100),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final item = myList[index];
                        return buildNote(item);
                      },
                      itemCount: myList.length,
                    ),
                  ),
                ),
              ),
            ]));
  }
}
