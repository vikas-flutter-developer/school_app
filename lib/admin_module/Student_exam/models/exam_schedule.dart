// models/exam_schedule.dart (Create this file)
import 'package:equatable/equatable.dart';

class ExamSchedule extends Equatable {
  final String srNo;
  final String examDate; // Store as String for simplicity, consider DateTime if needed
  final String subject;
  final String timing;   // Store as String
  final String invigilator;
  final String roomNo;

  const ExamSchedule({
    required this.srNo,
    required this.examDate,
    required this.subject,
    required this.timing,
    required this.invigilator,
    required this.roomNo,
  });

  @override
  List<Object?> get props => [srNo, examDate, subject, timing, invigilator, roomNo];
}

// Dummy data for demonstration
const List<ExamSchedule> dummyExams = [
  ExamSchedule(srNo: '1', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '2', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '3', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '4', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '5', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '6', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '7', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '8', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  ExamSchedule(srNo: '9', examDate: '00-00-00', subject: 'Lorem Ipsum', timing: '13:00-15:00', invigilator: 'Lorem Ipsum', roomNo: '120A'),
  // Add more if needed
];