class LeaveApplication {
  final String id;
  final String employeeName;
  final String employeeType;
  final String department;
  final String subDepartment;
  final String leaveType;
  final String reason;
  final String dateRange;
  final String paidType;
  final String approvalStatus;
  final DateTime date;
  final bool showApproveButton;

  LeaveApplication({
    required this.id,
    required this.employeeName,
    required this.employeeType,
    required this.department,
    required this.subDepartment,
    required this.leaveType,
    required this.reason,
    required this.dateRange,
    required this.paidType,
    required this.approvalStatus,
    required this.date,
    required this.showApproveButton,
  });
}
