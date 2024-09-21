import 'package:flutter/material.dart';
import 'package:notify/models/data.dart';

class Note {
  int id;
  String text;
  bool selected;
  bool important;
  Note(
    this.id,
    this.text,
    this.important,
    this.selected,
  );

//probably need to change this to a string to avoid sqlite errors
  Color getSelectedColor() {
    if (selected) {
      return NotifyColors.notifLightGray;
    } else {
      return NotifyColors.themeTwo;
    }
  }
}

class NoteInterface {
  static List<Note> noteList = [
    Note(0, "A", true, false),
    Note(1, "E", false, false),
    Note(2, "I", false, false),
    Note(3, "O", true, false),
    Note(4, "U", false, false),
  ];

  static void createNote(String newNoteText, bool newNoteImportance) {
    int newNoteIndex = 0;
    while (true) {
      if (noteList.indexWhere((element) => element.id == newNoteIndex) == -1) {
        break;
      } else {
        newNoteIndex++;
      }
    }
    Note newNote = Note(newNoteIndex, newNoteText, newNoteImportance, false);
    noteList.add(newNote);
  }

  static void add(Note newNote) {
    noteList.add(newNote);
  }

  static void swapNotes(Note note1, Note note2) {
    int noteOneIndex = noteList.indexWhere((element) => element.id == note1.id);
    int noteTwoIndex =
        noteList.indexWhere((element) => element.id == note2.id) - 1;
    noteList.removeWhere((element) => element.id == note1.id);
    noteList.removeWhere((element) => element.id == note2.id);
    noteList.insert(noteTwoIndex, note1);
    noteList.insert(noteOneIndex, note2);
  }

  static void delete(int index) {
    noteList.removeWhere(((element) => element.id == index));
  }

  static List<Note> get() {
    return noteList;
  }
}
