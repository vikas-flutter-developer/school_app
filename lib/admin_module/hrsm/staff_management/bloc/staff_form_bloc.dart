import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/staff_form_model.dart';
import 'staff_form_event.dart';
import 'staff_form_state.dart';

class StaffFormBloc extends Bloc<StaffFormEvent, StaffFormState> {
  StaffFormBloc() : super(StaffFormInitial()) {
    on<LoadStaffFormData>((event, emit) async {
      emit(StaffFormLoading());
      await Future.delayed(const Duration(milliseconds: 500));

      final staff = StaffFormModel(
        name: "John Doe",
        staffId: "A5 335 5547",
        department: "Science",
        mobile: "9876543210",
        email: "john@example.com",
        address: "123 Main Street",
        adharNumber: "1234-5678-9012",
        panNumber: "ABCDE1234F",
        salary: "15000",
        pfDeduction: "1000",
        bankName: "SBI",
        accountNumber: "2345 5668 7889 5677",
        ifsc: "SBIN0000001",
        dateOfJoining: "2022-01-01",
        relivingDate: "2025-07-03",
        remarks: "Good performance",
        academicYear: "2024",
        employeeType: "Full Time",
        education: "Masters",
        percentage: "85",
        verificationStatus: "Verified",
        emergencyMobileNumber: "+91 67589 64748",
        photoUrl: "assets/images/img_3.png",
        isVerified: true,
      );

      emit(StaffFormLoaded(staff));
    });

    on<StaffFormFieldChanged>((event, emit) {
      final currentForm = state is StaffFormLoaded
          ? (state as StaffFormLoaded).form
          : StaffFormModel();
      final updatedForm = _updateFormField(currentForm, event.fieldName, event.value);
      emit(StaffFormLoaded(updatedForm));
    });

    on<SubmitStaffForm>((event, emit) async {
      emit(StaffFormSubmitting());
      await Future.delayed(const Duration(seconds: 1));
      emit(StaffFormSubmitSuccess());
    });
  }

  StaffFormModel _updateFormField(StaffFormModel form, String field, String value) {
    switch (field) {
      case 'name':
        return form.copyWith(name: value);
      case 'staffId':
        return form.copyWith(staffId: value);
      case 'department':
        return form.copyWith(department: value);
      case 'mobile':
        return form.copyWith(mobile: value);
      case 'email':
        return form.copyWith(email: value);
      case 'address':
        return form.copyWith(address: value);
      case 'adharNumber':
        return form.copyWith(adharNumber: value);
      case 'panNumber':
        return form.copyWith(panNumber: value);
      case 'salary':
        return form.copyWith(salary: value);
      case 'pfDeduction':
        return form.copyWith(pfDeduction: value);
      case 'bankName':
        return form.copyWith(bankName: value);
      case 'accountNumber':
        return form.copyWith(accountNumber: value);
      case 'ifsc':
        return form.copyWith(ifsc: value);
      case 'dateOfJoining':
        return form.copyWith(dateOfJoining: value);
      case 'relivingDate':
        return form.copyWith(relivingDate: value);
      case 'remarks':
        return form.copyWith(remarks: value);
      case 'academicYear':
        return form.copyWith(academicYear: value);
      case 'employeeType':
        return form.copyWith(employeeType: value);
      case 'education':
        return form.copyWith(education: value);
      case 'percentage':
        return form.copyWith(percentage: value);
      case 'verificationStatus':
        return form.copyWith(verificationStatus: value);
      case 'photoUrl':
        return form.copyWith(photoUrl: value);
      case 'isVerified':
        return form.copyWith(isVerified: value.toLowerCase() == 'true');
      case 'emergencyMobileNumber':               // NEW
        return form.copyWith(emergencyMobileNumber: value);
      default:
        return form;
    }
  }
}
