import 'package:agenda/finance/cards/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Notas/provider/theme_provider.dart';
import '../alma_finance/billetera_provider.dart';
// import '../alma_finance/icon_notifier.txt';
import '../alma_finance/card_provider.dart';
import 'arriba.dart';

import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddCards extends StatefulWidget {
  final Wallet? wallet;
  const AddCards({Key? key, this.wallet}) : super(key: key);

  @override
  State<AddCards> createState() => _AddCardsState();
}

class _AddCardsState extends State<AddCards> {
  //Parte del codigo de iconos
  // IconNotifier notifier;

  // @override
  // void initState() {
  //   super.initState();
  //   notifier = Provider.of<IconNotifier>(context, listen: false);
  // }
  //
  Icon? _icon;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final billeteraProvider = Provider.of<BilleteraProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
      body: Column(
        key: _formKey,
        children: <Widget>[
          //Arriba
          arriba(lightTheme: lightTheme),
          //Abajo
          abajo(lightTheme),
        ],
      ),
    );
  }

  Expanded abajo(bool lightTheme) {
    final billeteraProvider = Provider.of<BilleteraProvider>(context);

    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: lightTheme == false
              ? const Color(0xFF1e1f1f)
              : const Color(0xFFf5f5ee),
        ),
        //Recuadro de abajo

        child: Container(
          color: lightTheme == false
              ? const Color(0xFF252427)
              : const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: nameActivity(lightTheme, billeteraProvider),
        ),
      ),
    );
  }

  Column nameActivity(bool lightTheme, BilleteraProvider billeteraProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Actividad
        Text(
          "Actividad",
          style: TextStyle(
            color: lightTheme == false ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              left: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              right: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              bottom: BorderSide(
                color: lightTheme == false
                    ? const Color(0xFFf5f5ee)
                    : const Color(0xFF1e1f1f),
              ),
            ),
          ),
          child: TextFormField(
            onChanged: (value) {
              // billeteraProvider.actualizaDineros(int.string(value));
            },
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Cine'),
          ),
        ),
        //input
        const SizedBox(
          height: 25,
        ),
        Text(
          "Cantidad ",
          style: TextStyle(
            color: lightTheme == false ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              left: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              right: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              bottom: BorderSide(
                color: lightTheme == false
                    ? const Color(0xFFf5f5ee)
                    : const Color(0xFF1e1f1f),
              ),
            ),
          ),
          child: TextFormField(
            onChanged: (value) {
              // billeteraProvider.actualizaDineros(int.parse(value));
            },
            style: const TextStyle(fontSize: 20),
            decoration:
                const InputDecoration(border: InputBorder.none, hintText: '0'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        //Selection icon
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Selecciona tu icono ",
              style: TextStyle(
                color: lightTheme == false ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                onPressed: _pickIcon,
                icon: Icon(
                  Icons.catching_pokemon_sharp,
                  color: lightTheme == false ? Colors.white : Colors.black,
                  size: 22.5,
                ),
              ),
            ),
          ],
        ),
        //Muestra el icono
        const SizedBox(
          height: 10,
        ),
        // Consumer<IconNotifier>(
        //   builder: (BuildContext ctx, dynamic d, Widget w) => AnimatedSwitcher(
        //     duration: const Duration(milliseconds: 300),
        //     child: notifier.iconData != null
        //         ? Column(
        //             children: [
        //               Icon(notifier.iconData),
        //             ],
        //           )
        //         : Container(),
        //   ),
        // ),
      ],
    );
  }

  //Tajera
  Container buildCategoryCard(
      IconData icon, String title, int amount, int percentage) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF00B686),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "\$$amount",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "($percentage%)",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300),
              ),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0XFF00B686)),
              ),
            ],
          )
        ],
      ),
    );
  }

  //
  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      customIconPack: {
        'i1': MyIconos.i1,
        'i2': MyIconos.i2,
        'i3': MyIconos.i3,
        'i4': MyIconos.i4,
        'i5': MyIconos.i5,
        'i7': MyIconos.i7,
        'i8': MyIconos.i8,
        'i9': MyIconos.i9,
        'i10': MyIconos.i10,
        'i11': MyIconos.i11,
        'i13': MyIconos.i13,
        'i14': MyIconos.i14,
        'i15': MyIconos.i15,
        'i16': MyIconos.i16,
        'i24': MyIconos.i24,
        'i25': MyIconos.i25,
        'i26': MyIconos.i26,
        'i27': MyIconos.i27,
        'i27_1': MyIconos.i27_1,
        'i28': MyIconos.i28,
        'i29': MyIconos.i29,
        'i30': MyIconos.i30,
        'i29_1': MyIconos.i29_1,
        'i30_1': MyIconos.i30_1,
        'i31': MyIconos.i31,
        'i32': MyIconos.i32,
        'i33': MyIconos.i33,
        'i33_1': MyIconos.i33_1,
        'i34': MyIconos.i34,
        'i35': MyIconos.i35,
        'i36': MyIconos.i36,
        'i37_1': MyIconos.i37_1,
        'i38': MyIconos.i38,
        'i39': MyIconos.i39,
        'i39_1': MyIconos.i39_1,
        'i40': MyIconos.i40,
        'i44': MyIconos.i44,
      },
      iconPackModes: [IconPack.custom],
    );

    _icon = Icon(icon);
    setState(() {});

    // if (icon != null) {
    //   notifier.iconData = icon;
    //   setState(() {});
    // }

    debugPrint('Escoge tu icono:  $icon');
  }

  // Future saveCard() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (isValid) {
  //     final wallet = Wallet(
  //         // cantidad: tittleController.text,
  //         // from: fromDate,
  //         );
  //     final isEditing2 = widget.wallet != null;
  //     final provider2 = Provider.of<BilleteraProvider>(context, listen: false);

  //     if (isEditing2) {
  //       provider2.(wallet, widget.wallet!);
  //       Navigator.of(context).pop();
  //     } else {
  //       provider2.addECard(wallet);
  //     }
  //     Navigator.of(context).pop();
  //   }
  // }
}
