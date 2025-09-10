import 'package:edudibon_flutter_bloc/admin_module/hrsm/payroll/bloc/payroll_event.dart';
import 'package:edudibon_flutter_bloc/admin_module/hrsm/payroll/bloc/payroll_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/payroll_data.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollInitial()) {
    on<LoadPayroll>((event, emit) async {
      emit(PayrollLoading());
      try {
        // Simulate API delay
        await Future.delayed(const Duration(seconds: 2));

        // Example data
        final data = [
          PayrollData("March 2025", 28, "37,674/-"),
          PayrollData("Feb 2025", 22, "27,674/-"),
          PayrollData("Jan 2025", 28, "37,674/-"),
        ];

        emit(PayrollLoaded(data));
      } catch (e) {
        emit(PayrollError("Failed to load payroll"));
      }
    });
  }
}
