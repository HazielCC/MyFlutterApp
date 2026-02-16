import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:agenda/sfCalendar/alma_local/provider_sf.dart';
import 'package:agenda/sfCalendar/editor_eventos.dart';
import 'package:agenda/sfCalendar/eventdata.dart';
import 'package:agenda/sfCalendar/eventos.dart';
import 'package:agenda/sfCalendar/visor_eventos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    final provider = Provider.of<EventProvider>(context);
    final selectedvents = provider.eventsOfSelectedDAte;
    //
    if (selectedvents.isEmpty) {
      return const Center(
        child: Text(
          'no hay algo que mostrar ',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
    //on tap largo para expandir horas
    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(
          fontSize: 14,
          color: lightTheme == false
              ? const Color(0xFFf5f5ee)
              : const Color(0xFF1e1f1f),
        ),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: lightTheme == false
            ? const Color(0xFFf5f5ee)
            : const Color(0xFF1e1f1f),
        selectionDecoration: const BoxDecoration(color: Colors.transparent),
        onTap: (details) {
          if (details.appointments == null) return;
          final event = details.appointments!.first;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventViewingPage(event: event),
            ),
          );
        },
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightTheme == false
            ? const Color(0xFFf5f5ee)
            : const Color(0xFF1e1f1f),
      ),
      child: Center(
        child: Text(
          event.tittle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            // color: Colors.amber,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: lightTheme == false
                ? const Color(0xFF1e1f1f)
                : const Color(0xFFf5f5ee),
          ),
        ),
      ),
    );
  }
}
