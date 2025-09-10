import '../model/payroll_data.dart';

abstract class PayrollState {}

class PayrollInitial extends PayrollState {}

class PayrollLoading extends PayrollState {}

class PayrollLoaded extends PayrollState {
  final List<PayrollData> payrolls;
  PayrollLoaded(this.payrolls);
}

class PayrollError extends PayrollState {
  final String message;
  PayrollError(this.message);
}
