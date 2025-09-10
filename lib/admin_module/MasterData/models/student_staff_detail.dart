// models/student_staff_detail.dart
import 'package:equatable/equatable.dart';

// Using a common base class or separate classes
// Here using separate classes for clarity

class StudentDetailItem extends Equatable {
  final String srNo;
  final String admissionNo;
  final String studentName;
  final String status;
  final String contactNo; // From enhanced view
  final String section;   // From enhanced view

  const StudentDetailItem({
    required this.srNo,
    required this.admissionNo,
    required this.studentName,
    required this.status,
    required this.contactNo,
    required this.section,
  });

  @override
  List<Object?> get props => [srNo, admissionNo, studentName, status, contactNo, section];
}

class StaffDetailItem extends Equatable {
  final String srNo;
  final String employeeId;
  final String staffName;
  final String email;
  final String contactNo;
  final String department;

  const StaffDetailItem({
    required this.srNo,
    required this.employeeId,
    required this.staffName,
    required this.email,
    required this.contactNo,
    required this.department,
  });

  @override
  List<Object?> get props => [srNo, employeeId, staffName, email, contactNo, department];
}

// Dummy Data
const List<StudentDetailItem> dummyStudentDetails = [
  StudentDetailItem(srNo: '1', admissionNo: '4456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '2', admissionNo: '8456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '3', admissionNo: '4456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '4', admissionNo: '8456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '5', admissionNo: '8456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '6', admissionNo: '0456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '7', admissionNo: '6456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '8', admissionNo: '9456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
  StudentDetailItem(srNo: '9', admissionNo: '4456789', studentName: 'Lorem Ipsum', status: 'Lorem', contactNo: 'Lorem Ipsum', section: 'Lorem Ipsum'),
];

const List<StaffDetailItem> dummyStaffDetails = [
  StaffDetailItem(srNo: '1', employeeId: '4456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '2', employeeId: '8456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '3', employeeId: '4456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '4', employeeId: '8456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '5', employeeId: '8456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '6', employeeId: '0456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '7', employeeId: '6456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '8', employeeId: '9456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
  StaffDetailItem(srNo: '9', employeeId: '4456789', staffName: 'Lorem Ipsum', email: 'Lorem', contactNo: 'Lorem Ipsum', department: 'Lorem Ipsum'),
];