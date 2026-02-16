import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:agenda/model/theme_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../settings/edit_profile_page.dart';
import '../settings/profile_widget.dart';
import '../settings/user.dart';
import '../settings/user_preferences.dart';

class Settingss extends StatelessWidget {
  const Settingss({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool darkModeCheck =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Ajustes',
            style: themeProvider.themeControl(20, FontWeight.normal)),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            const SizedBox(height: 24),

            //
            //buildName(user),
            Column(
              children: [
                Text(user.name,
                    style: themeProvider.themeControl(18, FontWeight.bold)),
                const SizedBox(height: 4),
              ],
            ),
            //
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Estilo de Fuente',
                            style: themeProvider.themeControl(
                                18, FontWeight.normal)),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {},
                            child: ListTile(
                              title: Text('Open Sans',
                                  style: themeProvider.themeControl(
                                      16, FontWeight.normal)),
                              leading: Radio(
                                value: GoogleFonts.openSansTextTheme(),
                                groupValue: themeProvider.choosedFont,
                                onChanged: (newValue) {
                                  themeProvider.putThemeModel(
                                    ThemeModel(
                                      fonttStyle: FonttStyle.opensans,
                                      lightMode: themeProvider
                                          .hiveLocalStorage.fontStyleBox
                                          .getAt(0)!
                                          .lightMode,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {},
                            child: ListTile(
                              title: Text('Lato',
                                  style: themeProvider.themeControl(
                                      16, FontWeight.normal)),
                              leading: Radio(
                                value: GoogleFonts.latoTextTheme(),
                                groupValue: themeProvider.choosedFont,
                                onChanged: (newValue) {
                                  themeProvider.putThemeModel(
                                    ThemeModel(
                                      fonttStyle: FonttStyle.lato,
                                      lightMode: themeProvider
                                          .hiveLocalStorage.fontStyleBox
                                          .getAt(0)!
                                          .lightMode,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ListTileStyle.drawer,
                leading: const Icon(Icons.font_download_outlined),
                title: Text(
                  'Fuente',
                  style: themeProvider.themeControl(18, FontWeight.normal),
                ),
                trailing: const Icon(Icons.arrow_forward_rounded),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                style: ListTileStyle.drawer,
                leading: const Icon(Icons.sunny),
                title: Text(
                  'Modo Noche / Claro',
                  style: themeProvider.themeControl(18, FontWeight.normal),
                ),
                trailing: Switch(
                  value: themeProvider.hiveLocalStorage.fontStyleBox
                      .getAt(0)!
                      .lightMode,
                  onChanged: (newValue) {
                    themeProvider.switchState(newValue);
                  },
                  inactiveTrackColor: const Color(0xFF10899d),
                  inactiveThumbColor: Colors.black,
                  activeColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
