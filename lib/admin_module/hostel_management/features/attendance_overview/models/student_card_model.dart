import 'package:flutter/material.dart';

class StudentCardModel {
  final String roomSeat;
  final String name;
  final String email;
  final String phone;
  final String department;
  final String year;
  final String profileImageUrl;
  final String status; // 'Checked In', 'Pending', 'On leave'
  final String statusText;
  final Color statusColor;
  final String time; // Relevant for 'Checked In' and 'Pending'

  StudentCardModel({
    required this.roomSeat,
    required this.name,
    required this.email,
    required this.phone,
    required this.department,
    required this.year,
    required this.profileImageUrl,
    required this.status,
    required this.statusText,
    required this.statusColor,
    required this.time,
  });
}
