import 'dart:async';

import 'package:agenda/sfCalendar/alma_local/provider_sf.dart';
import 'package:agenda/sfCalendar/editor_eventos.dart';
import 'package:agenda/sfCalendar/eventdata.dart';
import 'package:agenda/sfCalendar/tasker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Notas/provider/theme_provider.dart';
import '../constans/drawer.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    final eventProvider = Provider.of<EventProvider>(context);

    //Scaffold
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
//       //importaticon de drawer
      drawer: const MyDrawer(width: 250),
      // cuerpo
      appBar: AppBar(
        title: Text(
          'Mi Calendario',
          style: TextStyle(
            color: lightTheme == false
                ? const Color(0xFFe8e9e9)
                : const Color(0xFF323233),
          ),
        ),
      ),
      //
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
            color: Colors.blueAccent,
          ),
        ),
        child: SizedBox.fromSize(
          size: const Size.square(40),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.add,
              color: lightTheme == false
                  ? const Color(0xFFe8e9e9)
                  : const Color(0xFF323233),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditEventos(),
                ),
              );
            },
          ),
        ),
      ),
      //
      body: Row(
        children: [
          SfCalendar(
            view: CalendarView.month,
            dataSource: EventDataSource(events),
            cellBorderColor: Colors.transparent,
            initialDisplayDate: DateTime.now(),
            headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
            headerHeight: 50,
            //

            //
            onLongPress: (details) {
              final provider =
                  Provider.of<EventProvider>(context, listen: false);
              provider.setDate(details.date!);
              showModalBottomSheet(
                context: context,
                builder: (context) => const TaskWidget(),
              );
            },

            //Here we modifi the view of calenday
            monthViewSettings: const MonthViewSettings(
              monthCellStyle: MonthCellStyle(
                trailingDatesTextStyle:
                    TextStyle(fontSize: 15, color: Colors.grey),
              ),
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          ),
        ],
      ),
    );
  }
}
