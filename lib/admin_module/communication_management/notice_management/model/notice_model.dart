import 'package:flutter/material.dart';

class Notice {
  final String id;
  final String title;
  final String body;
  final String status;
  final Color statusColor;
  final Color bgColor;
  final Color barColor;
  final String sentTo;
  final bool showEditDelete;

  Notice({
    required this.id,
    required this.title,
    required this.body,
    required this.status,
    required this.statusColor,
    required this.bgColor,
    required this.barColor,
    required this.sentTo,
    required this.showEditDelete,
  });
}

class Recipient {
  final String name;
  final String number;

  Recipient({required this.name, required this.number});
}
