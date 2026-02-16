import 'package:flutter/material.dart';
import 'package:pass_flutter/pass_flutter.dart';

import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../constans/drawer.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(scaffoldBackgroundColor: Colors.black),
      //frontpage
      child: Scaffold(
        drawer: const MyDrawer(width: 250),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                //TITTLE
                const _Start(),
                //ticket 1
                SliverStickyHeader(
                  header: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF12b2ce),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: const Text(
                      'Prueba',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Start extends StatelessWidget {
  const _Start({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 80,
        color: Colors.black,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            const Text(
              'Cartera',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 20,
        ),
      ),
    );
  }
}
