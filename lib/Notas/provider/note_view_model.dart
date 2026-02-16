import 'package:agenda/Notas/models/note.dart';
import 'package:flutter/cupertino.dart';

import '../database/local_storage.dart';

class NoteViewModel extends ChangeNotifier {
  HiveLocalStorage hiveLocalStorage = HiveLocalStorage();

  void addNote(Note note) {
    hiveLocalStorage.noteBox.add(note);
    notifyListeners();
  }

  Future deleteNote(Note note) async {
    note.delete();
    notifyListeners();
  }

  Future removeNote(Note note) async {
    await hiveLocalStorage.noteBox.delete(note);
    notifyListeners();
  }

  void updateNote(Note note, int index) {
    hiveLocalStorage.updateEvent(index: index, calen: note);
    notifyListeners();
  }

  void deleteNoteIndex(int index) {
    hiveLocalStorage.noteBox.deleteAt(index);
    notifyListeners();
  }

  void updateSearchDelegate(Note note, String not, String title) {
    hiveLocalStorage.updateNoteSearchPage(note: note, not: not, titlee: title);
    notifyListeners();
  }
}
