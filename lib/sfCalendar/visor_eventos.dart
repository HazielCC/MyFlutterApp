import 'package:agenda/sfCalendar/editor_eventos.dart';
import 'package:agenda/sfCalendar/eventos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:agenda/sfCalendar/alma_local/provider_sf.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildViewingActions(context, event),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          buildDateTime(event),
          const SizedBox(height: 32),
          Text(
            event.tittle,
            style: TextStyle(
              fontSize: 20,
              color: lightTheme == false
                  ? const Color(0xFFf5f5ee)
                  : const Color(0xFF1e1f1f),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(event.description,
              style: TextStyle(
                fontSize: 15,
                color: lightTheme == false
                    ? const Color(0xFFf5f5ee)
                    : const Color(0xFF1e1f1f),
              ))
        ],
      ),
    );
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(
          event.isAllDay ? 'Todo el día' : 'Anti todo el día',
          event.from,
        ),
        if (!event.isAllDay) buildDate('De', event.to),
      ],
    );
  }

  Widget buildDate(String tittle, DateTime date) {
    return Container();
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    final eventProvider = Provider.of<EventProvider>(context);
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EditEventos(event: event),
          ),
        ),
      ),
      IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            eventProvider.deleteEvent(event);
            // removeEventss(event);
            Navigator.of(context).pop();
          }),
    ];
  }
}
