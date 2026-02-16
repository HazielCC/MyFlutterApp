import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../model/theme_model.dart';
import '../models/note.dart';

abstract class LocalStorage extends HiveObject {
  Future<void> addEvent({required Note calen});
  Future<void> editEvent({required Note calen});
  Future<void> getNote({required String id});
  Future<void> deleteEvent({required Note calen});
  Future<void> updateEvent({required Note calen, required int index});
  Future<void> updateNoteSearchPage(
      {required Note note, required String not, required String titlee});
  Future<void> addThemeModel({required ThemeModel fontStyleModel});
  Future<void> putThemeModel({required ThemeModel fontStyleModel});
  Future<void> deleteThemeModel({
    required ThemeModel fontStyleModel,
  });
}

class HiveLocalStorage extends LocalStorage {
  late Box<Note> noteBox;
  late Box<ThemeModel> fontStyleBox;

  HiveLocalStorage() {
    noteBox = Hive.box<Note>('notx');
    fontStyleBox = Hive.box<ThemeModel>('fonty');
  }

  @override
  Future<void> addEvent({required Note calen}) async {
    noteBox.add(calen);
  }

  @override
  Future<void> editEvent({required Note calen}) async {
    noteBox.add(calen);
  }

  @override
  Future<void> deleteEvent({required Note calen}) async {
    noteBox.delete(calen);
  }

  @override
  Future<void> getNote({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent({required int index, required Note calen}) async {
    await noteBox.putAt(index, calen);
  }

  @override
  Future<void> updateNoteSearchPage(
      {required Note? note,
      required String not,
      required String titlee}) async {
    note!.note = not;
    note.title = titlee;
    note.createdAt = DateFormat.yMMMMd('en_US').format(DateTime.now());
    note.color = note.color;
    note.id = note.id;
    note.isArchived = note.isArchived;
    note.save();
  }

  @override
  Future<void> addThemeModel({required ThemeModel fontStyleModel}) async {
    await fontStyleBox.add(fontStyleModel);
  }

  @override
  Future<void> deleteThemeModel({required ThemeModel fontStyleModel}) async {
    await fontStyleBox.delete(key);
  }

  @override
  Future<void> putThemeModel({required ThemeModel fontStyleModel}) async {
    await fontStyleBox.putAt(0, fontStyleModel);
    fontStyleModel.save();
  }
}
