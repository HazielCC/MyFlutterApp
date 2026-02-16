import 'dart:ffi';

import 'package:agenda/finance/cards/addcard.dart';
import 'package:agenda/finance/change_bit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../Notas/provider/theme_provider.dart';
import '../constans/drawer.dart';
import '../finance/alma_finance/billetera_provider.dart';

class MyFinance extends StatefulWidget {
  const MyFinance({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFinance> createState() => _MyFinanceState();
}

class _MyFinanceState extends State<MyFinance> {
  @override
  Widget build(BuildContext context) {
    final billeteraProvider = Provider.of<BilleteraProvider>(context);

    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
      drawer: const MyDrawer(width: 200),
      //cuerpo
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/3.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0, top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 22.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                        height: 100.0,
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
                                  children: [
                                    Builder(
                                      builder: (context) => IconButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Thatsmymoney(),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.wallet,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            billeteraProvider.dinero.toString(),
                                        style: const TextStyle(
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
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Gastado',
                            style: TextStyle(
                              color: lightTheme == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.money_off_csred_rounded,
                            color: lightTheme == false
                                ? const Color(0XFF0e9fe8)
                                : const Color(0XFF015eb1),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: billeteraProvider.gastado.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: lightTheme == false
                                ? Colors.grey[200]
                                : Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 0.5,
                    height: 50,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              color: lightTheme == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.attach_money,
                            color: lightTheme == false
                                ? const Color(0XFF0e9fe8)
                                : const Color(0XFF015eb1),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: billeteraProvider.totalDinero.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: lightTheme == false
                                ? Colors.grey[200]
                                : Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //Tarjetas de gastos
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightTheme == false ? Colors.white : Colors.black,
                    ),
                  ),
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCards(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color:
                            lightTheme == false ? Colors.white : Colors.black,
                        size: 22.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              buildCategoryCard(Icons.fastfood, "Comida", 60, 30),
              const Padding(padding: EdgeInsets.only(top: 5)),
              // buildCategoryCard(Icons.flash_on, "Transporte", 500, 17),
              // const Padding(padding: EdgeInsets.only(top: 5)),
              // buildCategoryCard(Icons.devices_other, "otro", 4800, 20),
            ],
          ),
        ),
      ),
    );
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
