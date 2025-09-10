import 'package:flutter/material.dart';

class SyllabusItems {
  final String id; // Added an ID
  final String title;
  final String description;
  final double progress;
  final Color color;

  SyllabusItems({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.color,
  });
}
