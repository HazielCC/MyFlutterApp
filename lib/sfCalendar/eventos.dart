import 'package:flutter/material.dart';

class Event {
  final String tittle;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.tittle,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = const Color(0xFF10899d),
    this.isAllDay = false,
  });

  Map<String, dynamic> toJson() => {
        'tittle': tittle,
        'description': description,
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
      };

  static Event fromJson(Map<String, dynamic> json) => Event(
        description: json['description'],
        tittle: json['tittle'],
        from: DateTime.parse(json['from']),
        to: DateTime.parse(json['to']),
      );
}
