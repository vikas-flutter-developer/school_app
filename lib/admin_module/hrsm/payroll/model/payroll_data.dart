class PayrollData {
  final String monthYear;
  final int workingDays;
  final String totalCredited;

  PayrollData(this.monthYear, this.workingDays, this.totalCredited);
}
class Payroll {
  final String employeeName;
  final String month;
  final String amount;
  final String status;

  Payroll({
    required this.employeeName,
    required this.month,
    required this.amount,
    required this.status,
  });
}
