import 'package:flutter/material.dart';

import '../../wallpaper/finance.dart';

class arriba extends StatelessWidget {
  const arriba({
    Key? key,
    required this.lightTheme,
  }) : super(key: key);

  final bool lightTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10.0, top: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //apbar
            children: <Widget>[
              Row(
                children: [
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
                  Text(
                    '¡Hola Haziel!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: lightTheme == false ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyFinance(),
                      ),
                    );
                  },
                  icon: Icon(Icons.check,
                      color: lightTheme == false ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
