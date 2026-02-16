import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/note.dart';
import '../provider/note_view_model.dart';
import '../provider/theme_provider.dart';
import '../widgets/color_choose_circle.dart';
import '../widgets/text_field.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({
    Key? key,
  }) : super(key: key);
  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerNote = TextEditingController();
  late bool darkModeEnabled;
  int choosedColor = Colors.transparent.value;
  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode == true
        ? darkModeEnabled = false
        : darkModeEnabled = true;
    return Scaffold(
        backgroundColor: Color(themeControl()),
        appBar: AppBar(
          backgroundColor: Color(themeControl()),
          leading: IconButton(
              onPressed: () {
                if (controllerNote.text.isEmpty &&
                    controllerTitle.text.isEmpty) {
                  noteViewModel.removeNote(Note(
                    color: choosedColor,
                    id: UniqueKey().hashCode,
                    title: controllerTitle.text,
                    note: controllerNote.text,
                    isArchived: false,
                    createdAt:
                        DateFormat.yMMMMEEEEd('en_US').format(DateTime.now()),
                  ));
                  debugPrint('Empty note is deleted');
                } else {
                  noteViewModel.addNote(Note(
                    color: choosedColor,
                    id: UniqueKey().hashCode,
                    title: controllerTitle.text,
                    isArchived: false,
                    note: controllerNote.text,
                    createdAt:
                        DateFormat.yMMMMd('en_US').format(DateTime.now()),
                  ));
                }
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          elevation: 0,
          title: const Text('Crea tu nota'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFieldd(
                  controller: controllerTitle,
                  hintText: 'Titulo',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                TextFieldd(
                  controller: controllerNote,
                  hintText: 'Dime tu pensar',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                )
              ],
            ),
          ),
        ),
        bottomSheet: bttmSheet(context));
  }

  int themeControl() => choosedColor == Colors.transparent.value
      ? darkModeEnabled == true
          ? Constants.darkModeBackgrounColor.value
          : Colors.white.value
      : choosedColor;

  Container bttmSheet(BuildContext context) {
    return Container(
      color: Color(themeControl()),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                        height: 80,
                        color: Constants.darkModeBackgrounColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    choosedColor = Colors.transparent.value;
                                  });
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        style: BorderStyle.solid,
                                        color: Colors.black,
                                      )),
                                  child: const Icon(Icons.block),
                                )),
                            ColorChooseCircle(
                                color: const Color(0xFFcaab5f),
                                onPress: () async {
                                  setState(() {
                                    choosedColor =
                                        const Color(0xFF9F478C).value;
                                  });
                                }),
                            ColorChooseCircle(
                                color: const Color(0xFFB5B98),
                                onPress: () {
                                  setState(() {
                                    choosedColor =
                                        const Color(0xFF1e885a).value;
                                  });
                                }),
                            ColorChooseCircle(
                                color: const Color(0xFF066b94),
                                onPress: () async {
                                  setState(() {
                                    choosedColor =
                                        const Color(0xFF066b94).value;
                                  });
                                }),
                            ColorChooseCircle(
                                color: const Color(0xFFfee883),
                                onPress: () {
                                  setState(() {
                                    choosedColor =
                                        const Color(0xFFfee883).value;
                                  });
                                }),
                            ColorChooseCircle(
                                color: const Color.fromARGB(255, 146, 104, 133),
                                onPress: () async {
                                  setState(() {
                                    choosedColor =
                                        const Color.fromARGB(255, 146, 104, 133)
                                            .value;
                                  });
                                }),
                            ColorChooseCircle(
                                color: const Color.fromARGB(255, 108, 88, 235),
                                onPress: () {
                                  setState(() {
                                    choosedColor =
                                        const Color.fromARGB(255, 108, 88, 235)
                                            .value;
                                  });
                                }),
                          ],
                        ));
                  });
            },
            icon: const Icon(Icons.color_lens)),
      ]),
    );
  }
}
