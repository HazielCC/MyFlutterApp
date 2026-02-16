import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Notas/provider/theme_provider.dart';
import 'card_provider.dart';

String valor = "";

class CardActivity extends StatefulWidget {
  const CardActivity({Key? key}) : super(key: key);

  @override
  State<CardActivity> createState() => _CardActivityState();
}

class _CardActivityState extends State<CardActivity> {
  final List<String> listaGastos = [];
// me falta modificar el career
  // @override
  // void initState() {
  //   final Gasto1 = Wallet(
  //       icon: Icons.dangerous, actividad: '', cantidad: 0, porcentaje: 0);
  //   final Gasto2 = Wallet(
  //       icon: Icons.dangerous, actividad: '', cantidad: 0, porcentaje: 0);

  //   print('Los estudiantes son iguales ${Gasto1 == Gasto2}');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final carteraProvider = Provider.of<Wallet>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
        body: Column(
      children: <Widget>[
        buildCategoryCard(Icons.fastfood, "Comida", 60, 30),
        const Padding(padding: EdgeInsets.only(top: 5)),
      ],
    ));
  }

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
}
