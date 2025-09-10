import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/employee_entity.dart';
import '../model/employee_model.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());

      // Simulated delay for loading
      await Future.delayed(const Duration(seconds: 1));

      // Dummy employee data with documentLabels added
      final employee = EmployeeModel(
        name: 'John Doe',
        email: 'john.doe@example.com',
        mobile: '9876543210',
        address: '123 Main Street, City',
        staffId: 'EMP12345',
        profileImageUrl: '', // Empty or network image
        department: 'Engineering',
        subDepartment: 'Mobile Team',
        subject: 'Flutter Development',
        adharCardNumber: '1234-5678-9101',
        pancardNumber: 'ABCDE1234F',
        documentDepartment: 'HR',
        documentImages: [
          'https://example.com/adhar.png',
          'https://example.com/pan.png',
        ],
        documentLabels: [ // Newly added field
          'Aadhar Card',
          'PAN Card',
        ],
        joiningDate: '2021-01-01',
        relievingDate: '',
        employeeType: 'Permanent',
        renewals: '2025',
        verification: 'Verified',
        leaves: LeaveInfo(
          total: 30,
          sick: 5,
          casual: 10,
          remaining: 15,
        ),
        salary: SalaryInfo(
          ctc: 12,
          fixed: 8,
          variable: 2,
          benefits: 2,
          deduction: 0.5,
        ),
        bankDetails: BankDetails(
          bankName: 'SBI',
          branch: 'MG Road',
          accountType: 'Savings',
          accountNumber: 123456789011,
          ifscCode: 'SBIN0001234',
        ),
        attendancePercent: 94.5, role: 'teacher',
      );
      emit(EmployeeLoaded(employee));
    });
  }
}
