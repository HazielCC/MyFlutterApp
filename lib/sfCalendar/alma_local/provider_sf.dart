import 'dart:convert';
import 'dart:io';

import 'package:agenda/sfCalendar/editor_eventos.dart';
import 'package:agenda/sfCalendar/eventos.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class EventProvider extends ChangeNotifier {
  //Cargar Archivo
  EventProvider() {
    cargarEvent();
  }
  void cargarEvent() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}\\evento.json');
    if (file.existsSync()) {
      final filedata = await file.readAsString();
      final List eventList = jsonDecode(filedata);
      _events.addAll(eventList.map((e) => Event.fromJson(e)));
    }
  }

//
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  //Metodo sobre la fecha de creación
  List<Event> get eventsOfSelectedDAte => _events;

  void addEvent(Event event) async {
    _events.add(event);
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}\\evento.json');
    final String jsonString = jsonEncode(_events);
    file.writeAsString(jsonString);
    notifyListeners();
  }

  deleteEvent(Event event) {
    _events.remove(event);
    addEvent(event);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = (newEvent);

    notifyListeners();
  }
}
