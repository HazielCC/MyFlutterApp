import 'package:agenda/Notas/constants.dart';
import 'package:agenda/Notas/models/note.dart';
import 'package:agenda/Notas/provider/note_view_model.dart';
import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:agenda/Notas/route/route_generator.dart';
import 'package:agenda/finance/alma_finance/billetera_provider.dart';
import 'package:agenda/model/theme_model.dart';
import 'package:agenda/sfCalendar/editor_eventos.dart';
import 'package:agenda/wallpaper/finance.dart';
import 'package:agenda/wallpaper/front_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'finance/alma_finance/icon_notifier.txt';
import 'sfCalendar/alma_local/provider_sf.dart';
import 'wallpaper/notes_page.dart';
import 'wallpaper/splash_screen.dart';

import 'wallpaper/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ThemeModelAdapter());
  Hive.registerAdapter(FonttStyleAdapter());
  await Hive.openBox<Note>('notx');
  await Hive.openBox<ThemeModel>('fonty');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteViewModel()),
    ChangeNotifierProvider(create: (context) => BilleteraProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SfCalendar
    final eventProvider = Provider.of<EventProvider>(context);
    // Icono
    // final notifier = IconNotifier.init();
    // Tema
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.fontControl();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      onGenerateRoute: RouteGenerator.routeGenerator,
      theme: themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode ==
              false
          ? ThemeData.dark().copyWith(
              textTheme: themeProvider.changeFont(),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent.withOpacity(0.05),
                ),
                color: Constants.darkModeBackgrounColor,
              ),
              scaffoldBackgroundColor: Constants.darkModeBackgrounColor,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              textTheme: themeProvider.changeFont(),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.transparent.withOpacity(0.05),
                ),
                color: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
            ),

      //here is the diferents routes of the program

      initialRoute: 'Finanzas',
      routes: {
        'Calendario': (context) => const FrontPage(),
        'Boletos': (context) => EditEventos(),
        'Notas': (context) => NotesPage(),
        'Finanzas': (context) => MyFinance(),
        'Ajustes': (context) => const Settingss(),
        'SplashScreen': (context) => const SplashScreen(),
        // 'profile': (context) => EditProfilePage(),
      },
    );
  }
}
