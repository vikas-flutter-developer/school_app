part of 'staff_form_bloc.dart';

abstract class StaffFormEvent {}

class LoadStaffForm extends StaffFormEvent {
  final StaffMember? staffMember; // Null for new, existing for edit
  LoadStaffForm({this.staffMember});
}

class NameChanged extends StaffFormEvent {
  final String name;
  NameChanged(this.name);
}

class MobileChanged extends StaffFormEvent {
  final String mobile;
  MobileChanged(this.mobile);
}

class EmailChanged extends StaffFormEvent {
  final String email;
  EmailChanged(this.email);
}

class DepartmentChanged extends StaffFormEvent {
  final String? department;
  DepartmentChanged(this.department);
}

class AcademicYearChanged extends StaffFormEvent {
  final String? academicYear;
  AcademicYearChanged(this.academicYear);
}

class PermanentAddressChanged extends StaffFormEvent {
  final String address;
  PermanentAddressChanged(this.address);
}

class EmployeeTypeChanged extends StaffFormEvent {
  final String type;
  EmployeeTypeChanged(this.type);
}

class HighestEducationChanged extends StaffFormEvent {
  final String education;
  HighestEducationChanged(this.education);
}

class GradesChanged extends StaffFormEvent {
  final String grades;
  GradesChanged(this.grades);
}

class AdharCardNumberChanged extends StaffFormEvent {
  final String adhar;
  AdharCardNumberChanged(this.adhar);
}

class PancardNumberChanged extends StaffFormEvent {
  final String pan;
  PancardNumberChanged(this.pan);
}

class EmergencyMobileNumberChanged extends StaffFormEvent {
  final String emergencyMobile;
  EmergencyMobileNumberChanged(this.emergencyMobile);
}

class SalaryAmountChanged extends StaffFormEvent {
  final String salary;
  SalaryAmountChanged(this.salary);
}

class PfDeductionChanged extends StaffFormEvent {
  final String pf;
  PfDeductionChanged(this.pf);
}

class BankAccountNumberChanged extends StaffFormEvent {
  final String bankAccount;
  BankAccountNumberChanged(this.bankAccount);
}

class JoiningDateChanged extends StaffFormEvent {
  final String joiningDate;
  JoiningDateChanged(this.joiningDate);
}

class RelivingDateChanged extends StaffFormEvent {
  final String relivingDate;
  RelivingDateChanged(this.relivingDate);
}

class VerificationChanged extends StaffFormEvent {
  final String? verification;
  VerificationChanged(this.verification);
}

class AnyMessageChanged extends StaffFormEvent {
  final String message;
  AnyMessageChanged(this.message);
}

class UploadProfilePhoto extends StaffFormEvent {
  // In a real app, this might carry a File or path
}

class UploadIdProof extends StaffFormEvent {
  // In a real app, this might carry a File or path
}

class SubmitStaffForm extends StaffFormEvent {}
