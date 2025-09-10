// lib/staff_management/models/staff_member.dart
import 'package:flutter/foundation.dart'; // For kDebugMode or specific annotations

@immutable // Good practice for model classes used in BLoC
class StaffMember {
  final String id;
  final String department;
  final String name;
  final String mobile;
  final String email;
  final String address;
  final String type;
  final String
  status; // Used for Verification status ('Pending', 'Verified', 'Blocked')
  final String imageUrl;
  final String? academicYear;
  // permanentAddress is covered by 'address'
  // employeeType is covered by 'type'
  final String? highestEducation;
  final String? grades;
  final String? adharCardNumber;
  final String? pancardNumber;
  final String? emergencyMobileNumber;
  final String? salaryAmount;
  final String? pfDeduction;
  final String? bankAccountNumber;
  final String? joiningDate;
  final String? relivingDate;
  final String? anyMessage;

  const StaffMember({
    required this.id,
    required this.department,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.type,
    required this.status,
    required this.imageUrl,
    this.academicYear,
    this.highestEducation,
    this.grades,
    this.adharCardNumber,
    this.pancardNumber,
    this.emergencyMobileNumber,
    this.salaryAmount,
    this.pfDeduction,
    this.bankAccountNumber,
    this.joiningDate,
    this.relivingDate,
    this.anyMessage,
  });

  factory StaffMember.fromMap(Map<String, dynamic> map) {
    return StaffMember(
      id: map['id'] ?? 'N/A_${DateTime.now().millisecondsSinceEpoch}',
      department: map['department'] ?? 'Kitchen',
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? 'Contract',
      status: map['status'] ?? 'Pending',
      imageUrl:
          map['imageUrl'] ??
          'assets/images/profileimage.png', // Ensure this asset exists
      academicYear: map['academicYear'],
      highestEducation: map['highestEducation'],
      grades: map['grades'],
      adharCardNumber: map['adharCardNumber'],
      pancardNumber: map['pancardNumber'],
      emergencyMobileNumber: map['emergencyMobileNumber'],
      salaryAmount: map['salaryAmount'],
      pfDeduction: map['pfDeduction'],
      bankAccountNumber: map['bankAccountNumber'],
      joiningDate: map['joiningDate'],
      relivingDate: map['relivingDate'],
      anyMessage: map['anyMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'department': department,
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
      'type': type,
      'status': status,
      'imageUrl': imageUrl,
      'academicYear': academicYear,
      'highestEducation': highestEducation,
      'grades': grades,
      'adharCardNumber': adharCardNumber,
      'pancardNumber': pancardNumber,
      'emergencyMobileNumber': emergencyMobileNumber,
      'salaryAmount': salaryAmount,
      'pfDeduction': pfDeduction,
      'bankAccountNumber': bankAccountNumber,
      'joiningDate': joiningDate,
      'relivingDate': relivingDate,
      'anyMessage': anyMessage,
    };
  }

  factory StaffMember.empty() {
    return StaffMember(
      id: 'TEMP_${DateTime.now().millisecondsSinceEpoch}',
      department: 'Kitchen', // Default value
      name: '',
      mobile: '',
      email: '',
      address: '',
      type: 'Contract', // Default value
      status: 'Pending', // Default value for new staff
      imageUrl:
          'assets/images/profile_hostel_empleyee.jpeg', // Default placeholder, ensure asset exists
      academicYear: '2024 - 2025', // Default value
      highestEducation: '',
      grades: '',
      adharCardNumber: '',
      pancardNumber: '',
      emergencyMobileNumber: '',
      salaryAmount: '',
      pfDeduction: '',
      bankAccountNumber: '',
      joiningDate: '',
      relivingDate: '',
      anyMessage: '',
    );
  }

  // THIS IS THE MISSING METHOD: copyWith
  StaffMember copyWith({
    String? id,
    String? department,
    String? name,
    String? mobile,
    String? email,
    String? address,
    String? type,
    String? status,
    String? imageUrl,
    String? academicYear,
    String? highestEducation,
    String? grades,
    String? adharCardNumber,
    String? pancardNumber,
    String? emergencyMobileNumber,
    String? salaryAmount,
    String? pfDeduction,
    String? bankAccountNumber,
    String? joiningDate,
    String? relivingDate,
    String? anyMessage,
  }) {
    return StaffMember(
      id: id ?? this.id,
      department: department ?? this.department,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      academicYear: academicYear ?? this.academicYear,
      highestEducation: highestEducation ?? this.highestEducation,
      grades: grades ?? this.grades,
      adharCardNumber: adharCardNumber ?? this.adharCardNumber,
      pancardNumber: pancardNumber ?? this.pancardNumber,
      emergencyMobileNumber:
          emergencyMobileNumber ?? this.emergencyMobileNumber,
      salaryAmount: salaryAmount ?? this.salaryAmount,
      pfDeduction: pfDeduction ?? this.pfDeduction,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      joiningDate: joiningDate ?? this.joiningDate,
      relivingDate: relivingDate ?? this.relivingDate,
      anyMessage: anyMessage ?? this.anyMessage,
    );
  }
}
