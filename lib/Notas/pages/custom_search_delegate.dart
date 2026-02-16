import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../provider/note_view_model.dart';
import '../provider/theme_provider.dart';
import '../widgets/note_container.dart';
import 'edit_note_page.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query.isEmpty ? null : query = '',
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final noteBox = noteViewModel.hiveLocalStorage.noteBox;
    final filteredList = noteBox.values
        .where((element) => element.title.contains(query))
        .toList();
    return noteBox.values
            .where((element) => element.title.contains(query))
            .isNotEmpty
        ? Scaffold(
            body: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) {
                final itemIndex = filteredList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: NoteContainer(
                      color: Color(itemIndex.color),
                      title: itemIndex.title,
                      note: itemIndex.note,
                      createdAt: itemIndex.createdAt,
                      onPress: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditNotePage(
                                    editNote: itemIndex, index: index)));
                      }),
                );
              },
              itemCount: noteBox.values
                  .where((element) => element.title.contains(query))
                  .length,
            ),
          )
        : Center(
            child: Text(
              'Nota no encontrada',
              style: themeProvider.themeControl(21, FontWeight.normal),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
