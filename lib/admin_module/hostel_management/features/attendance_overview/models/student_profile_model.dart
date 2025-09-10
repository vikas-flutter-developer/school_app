class StudentProfileModel {
  final String roomSeat;
  final String name;
  final String profileImageUrl;
  final String expiryDate; // e.g., "02/03/25"
  final String email;
  final String mobile;
  final String department;
  final String year;
  final String address;
  final String parentName;
  final String parentRelation;
  final String parentMobile;
  final String parentOccupation;
  final String advancePayment;
  final String pendingPayment;
  final String pendingDueDate;
  final String cautionMoney;
  final String medicalConditions;
  final String allergies;
  final String phobias;
  final String doctorName;
  final String doctorContact;

  StudentProfileModel({
    required this.roomSeat,
    required this.name,
    required this.profileImageUrl,
    required this.expiryDate,
    required this.email,
    required this.mobile,
    required this.department,
    required this.year,
    required this.address,
    required this.parentName,
    required this.parentRelation,
    required this.parentMobile,
    required this.parentOccupation,
    required this.advancePayment,
    required this.pendingPayment,
    required this.pendingDueDate,
    required this.cautionMoney,
    required this.medicalConditions,
    required this.allergies,
    required this.phobias,
    required this.doctorName,
    required this.doctorContact,
  });
}
