class EmployeeEntity {
  final String staffId;
  final String name;
  final String email;
  final String role;
  final String mobile;
  final String address;
  final String profileImageUrl;
  final String department;
  final String subDepartment;
  final String subject;

  final String adharCardNumber;
  final String pancardNumber;
  final String documentDepartment;
  final List<String> documentImages;
  final List<String> documentLabels;

  final String joiningDate;
  final String relievingDate;
  final String employeeType;
  final String renewals;
  final String verification;

  final LeaveInfo leaves;
  final SalaryInfo salary;
  final BankDetails bankDetails;

  final double attendancePercent;

  const EmployeeEntity({
    required this.name,
    required this.email,
    required this.role,
    required this.mobile,
    required this.address,
    required this.staffId,
    required this.profileImageUrl,
    required this.department,
    required this.subDepartment,
    required this.subject,
    required this.adharCardNumber,
    required this.pancardNumber,
    required this.documentDepartment,
    required this.documentImages,
    required this.documentLabels,
    required this.joiningDate,
    required this.relievingDate,
    required this.employeeType,
    required this.renewals,
    required this.verification,
    required this.leaves,
    required this.salary,
    required this.bankDetails,
    required this.attendancePercent,
  });
}

class LeaveInfo {
  final int total;
  final int sick;
  final int casual;
  final int remaining;

  const LeaveInfo({
    required this.total,
    required this.sick,
    required this.casual,
    required this.remaining,
  });
}

class SalaryInfo {
  final double ctc;
  final double fixed;
  final double variable;
  final double benefits;
  final double deduction;

  const SalaryInfo({
    required this.ctc,
    required this.fixed,
    required this.variable,
    required this.benefits,
    required this.deduction,
  });
}

class BankDetails {
  final String bankName;
  final String branch;
  final String accountType;
  final int accountNumber;
  final String ifscCode;

  const BankDetails({
    required this.bankName,
    required this.branch,
    required this.accountType,
    required this.accountNumber,
    required this.ifscCode,
  });
}
