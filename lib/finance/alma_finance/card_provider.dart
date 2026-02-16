import 'package:flutter/material.dart';

class Wallet {
  //Cards
  final int cantidad;
  final String actividad;
  final int porcentaje;
  final IconData icon;

  //Maths
  final int miDinero;
  final int gastado;
  final double total;

  Wallet({
    //Maths
    required this.actividad,
    required this.miDinero,
    required this.porcentaje,
    //Cards
    required this.cantidad,
    required this.gastado,
    required this.total,
    required this.icon,
  });

  Map<String, dynamic> toJson() => {
        //Cards
        'cantidad': cantidad,
        'actividad': actividad,
        'porcentaje': porcentaje,
        'icon': icon,
        //Mats
        'miDinero': miDinero,
        'gastado': gastado,
        'total': total,
      };

  static Wallet fromJson(Map<String, dynamic> json) => Wallet(
        //Cards
        cantidad: json['cantidad'],
        actividad: json['actividad'],
        porcentaje: json['porcentaje'],
        icon: json['icon'],
        //Maths
        miDinero: json['miDinero'],
        gastado: json['gastado'],
        total: json['total'],
      );

  bool operator ==(covariant Wallet other) {
    if (actividad == other.actividad) {
      return true;
    } else {
      return false;
    }
  }
}
