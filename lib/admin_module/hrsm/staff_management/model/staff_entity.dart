import 'package:equatable/equatable.dart';

class StaffEntity extends Equatable {
  final String name;
  final String staffId;
  final String department;
  final String mobile;
  final String email;
  final String address;
  final String adharNumber;
  final String panNumber;
  final String salary;
  final String bankName;
  final String accountNumber;
  final String ifsc;
  final String dateOfJoining;
  final String relivingDate;
  final String remarks;
  final String academicYear;
  final String employeeType;
  final String education;
  final String percentage;
  final String pfDeduction;
  final String verificationStatus;
  final String emergencyMobileNumber;  // NEW

  const StaffEntity({
    required this.name,
    required this.staffId,
    required this.department,
    required this.mobile,
    required this.email,
    required this.address,
    required this.adharNumber,
    required this.panNumber,
    required this.salary,
    required this.bankName,
    required this.accountNumber,
    required this.ifsc,
    required this.dateOfJoining,
    required this.relivingDate,
    required this.remarks,
    required this.academicYear,
    required this.employeeType,
    required this.education,
    required this.percentage,
    required this.pfDeduction,
    required this.verificationStatus,
    required this.emergencyMobileNumber,  // NEW
  });

  @override
  List<Object?> get props => [
    name,
    staffId,
    department,
    mobile,
    email,
    address,
    adharNumber,
    panNumber,
    salary,
    bankName,
    accountNumber,
    ifsc,
    dateOfJoining,
    relivingDate,
    remarks,
    academicYear,
    employeeType,
    education,
    percentage,
    pfDeduction,
    verificationStatus,
    emergencyMobileNumber,  // NEW
  ];
}
