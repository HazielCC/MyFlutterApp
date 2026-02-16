import 'package:agenda/Notas/database/local_storage.dart';
import 'package:agenda/Notas/models/note.dart';
import 'package:agenda/Notas/pages/create_note.page.dart';
import 'package:agenda/constans/drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';

import '../Notas/provider/note_view_model.dart';
import '../Notas/widgets/note_container.dart';
import '../Notas/widgets/sliver_app_bar.dart';
import '../Notas/pages/edit_note_page.dart';

class NotesPage extends StatelessWidget {
  NotesPage({Key? key}) : super(key: key);
  final HiveLocalStorage hiveLocalStorage = HiveLocalStorage();
  @override
  Widget build(BuildContext context) {
    Provider.of<NoteViewModel>(context);
    return Scaffold(
      drawer: const MyDrawer(width: 250),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            const SliverAppBarr(title: 'Notes'),
          ];
        },
        body: MasonryGridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final noteList = hiveLocalStorage.noteBox.values.toList();
              List<Note> noteListReversed = noteList.reversed.toList();
              final noteIndex2 = noteListReversed[index];
              return noteIndex2.isArchived == false
                  ? NoteContainer(
                      color: Color(noteIndex2.color),
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditNotePage(
                                  index: index, editNote: noteIndex2),
                            ));
                      },
                      title: noteIndex2.title,
                      note: noteIndex2.note,
                      createdAt: noteIndex2.createdAt,
                    )
                  : Container();
            },
            itemCount: hiveLocalStorage.noteBox.length),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNotePage(),
            ),
          );
        },
      ),
    );
  }
}
