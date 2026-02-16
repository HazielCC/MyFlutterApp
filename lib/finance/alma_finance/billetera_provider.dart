import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'card_provider.dart';

class BilleteraProvider extends ChangeNotifier {
  double dinero = 0;
  double gastado = 250;
  double total = 100;
  // Datos de almacenamiento

  BilleteraProvider() {
    cargarWallet();
  }
  void cargarWallet() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}\\Billetera.json');
    if (file.existsSync()) {
      final filedata = await file.readAsString();
      final List eventList = jsonDecode(filedata);
      _wallet.addAll(eventList.map((e) => Wallet.fromJson(e)));
    }
  }

  final List<Wallet> _wallet = [];
  List<Wallet> get events => _wallet;
  //Metodos
  void addECard(Wallet wallet) async {
    _wallet.add(wallet);
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}\\Billetera.json');
    final String jsonString = jsonEncode(_wallet);
    file.writeAsString(jsonString);
    notifyListeners();
  }

  // int total = dineros - gastado;
  void actMoney(double value) {
    dinero = value;
    notifyListeners();
  }

  void actGastado() {
    gastado;
    notifyListeners();
  }

  // void actTotal() {
  //   total;
  //   notifyListeners();
  // }

  void editCard(Wallet newCard, Wallet oldCard) {
    final index = _wallet.indexOf(oldCard);
    _wallet[index] = (newCard);

    notifyListeners();
  }

  double get totalDinero {
    total = dinero - gastado;
    return total;
  }
}
