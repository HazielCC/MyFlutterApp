import 'dart:ffi';

import 'package:agenda/finance/alma_finance/billetera_provider.dart';
import 'package:agenda/finance/change_bit.dart';
import 'package:agenda/wallpaper/finance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../Notas/provider/theme_provider.dart';
import '../constans/drawer.dart';
import 'alma_finance/billetera_provider.dart';

class Thatsmymoney extends StatefulWidget {
  const Thatsmymoney({Key? key}) : super(key: key);

  @override
  State<Thatsmymoney> createState() => _ThatsmymoneyState();
}

class _ThatsmymoneyState extends State<Thatsmymoney> {
  @override
  Widget build(BuildContext context) {
    final billeteraProvider = Provider.of<BilleteraProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;
    return Scaffold(
      // drawer: const MyDrawer(width: 200),
      //cuerpo
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/3.png"),
                fit: BoxFit.cover,
              ),
            ),
            //appbar
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0, top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //drawer
                      // Builder(
                      //   builder: (context) => IconButton(
                      //     onPressed: () {
                      //       Scaffold.of(context).openDrawer();
                      //     },
                      //     icon: const Icon(
                      //       Icons.menu,
                      //       color: Colors.white,
                      //       size: 22.5,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      //Nombre
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 7.5, right: 12.5),
                            child: CircleAvatar(
                              radius: 13.5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 12.5,
                                backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/406014/pexels-photo-406014.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '¡Hola Haziel!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 8,
                              spreadRadius: 3,
                            )
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        //cosa blanca
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Billetera ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Builder(
                                      builder: (context) => IconButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyFinance(),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: 'Introduce tu dinero',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //Recuadro de textos
                            Column(
                              children: [
                                _inputmoney(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //PArte de abajo
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/1.png', height: 350),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _inputmoney(BuildContext context) {
    final billeteraProvider =
        Provider.of<BilleteraProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          left: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          right: BorderSide(
            color: Color.fromARGB(255, 253, 253, 253),
          ),
          bottom: BorderSide(
            color: Color.fromARGB(255, 28, 57, 156),
          ),
        ),
      ),
      child: TextFormField(
        onChanged: (value) {
          billeteraProvider.actMoney(double.parse(value));
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
    );
  }
}
