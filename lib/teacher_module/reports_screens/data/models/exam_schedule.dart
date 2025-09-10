// lib/data/models/exam_schedule.dart
// Add models for Exam Schedule/Plan based on the different list styles shown
// Example:
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // For Color

enum ExamStatus { Completed, Ongoing, Postponed, Upcoming } // Added Upcoming

class ExamTimetableItem extends Equatable {
  final String subject;
  final String term;
  final DateTime dateTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String teacher;
  final String roomNo;
  final ExamStatus status;

  const ExamTimetableItem({
    required this.subject,
    required this.term,
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.teacher,
    required this.roomNo,
    required this.status,
  });

  @override
  List<Object?> get props => [
    subject,
    term,
    dateTime,
    startTime,
    endTime,
    teacher,
    roomNo,
    status,
  ];
}

class ExamPlanItem extends Equatable {
  final String subject;
  final String type; // e.g., Theory, Biology Theory
  final DateTime date;
  final TimeOfDay time;
  final Color color; // Or determine color based on subject/type

  const ExamPlanItem({
    required this.subject,
    required this.type,
    required this.date,
    required this.time,
    required this.color,
  });

  @override
  List<Object?> get props => [subject, type, date, time, color];
}
