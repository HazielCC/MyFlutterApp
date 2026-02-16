import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agenda/wallpaper/settings.dart';

class MyDrawer extends StatelessWidget {
  final double width;
  const MyDrawer({this.darkmode = false, Key? key, required this.width})
      : super(key: key);
  final bool darkmode;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;
    return Drawer(
// Color de todo
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: SizedBox(
            width: 250,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.calendar_month,
                    color: lightTheme == false
                        ? const Color(0xFFe8e9e9)
                        : const Color(0xFF323233),
                  ),
                  title: Text(
                    'Agenda',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightTheme == false
                          ? const Color(0xFFe8e9e9)
                          : const Color(0xFF323233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Calendario');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.savings_outlined,
                    color: lightTheme == false
                        ? const Color(0xFFe8e9e9)
                        : const Color(0xFF323233),
                  ),
                  title: Text(
                    'Finanzas ',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightTheme == false
                          ? const Color(0xFFe8e9e9)
                          : const Color(0xFF323233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Finanzas');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.airplane_ticket_outlined,
                    color: lightTheme == false
                        ? const Color(0xFFe8e9e9)
                        : const Color(0xFF323233),
                  ),
                  title: Text(
                    'Boletos ',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightTheme == false
                          ? const Color(0xFFe8e9e9)
                          : const Color(0xFF323233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Boletos');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.notes_rounded,
                    color: lightTheme == false
                        ? const Color(0xFFe8e9e9)
                        : const Color(0xFF323233),
                  ),
                  title: Text(
                    'Notas ',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightTheme == false
                          ? const Color(0xFFe8e9e9)
                          : const Color(0xFF323233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Notas');
                  },
                ),

                // Liniea Gris que dividide los ajustes de los demás
                const Divider(
                  indent: 5,
                  endIndent: 5,
                  color: Color.fromARGB(255, 92, 92, 92),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: lightTheme == false
                        ? const Color(0xFFe8e9e9)
                        : const Color(0xFF323233),
                  ),
                  title: Text(
                    'Ajustes',
                    style: TextStyle(
                      fontSize: 16,
                      color: lightTheme == false
                          ? const Color(0xFFe8e9e9)
                          : const Color(0xFF323233),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Ajustes');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
