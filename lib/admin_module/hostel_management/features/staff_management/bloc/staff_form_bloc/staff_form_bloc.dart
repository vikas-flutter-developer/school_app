import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/staff_member.dart';

part 'staff_form_event.dart';
part 'staff_form_state.dart';

class StaffFormBloc extends Bloc<StaffFormEvent, StaffFormState> {
  StaffFormBloc() : super(StaffFormState.initial()) {
    on<LoadStaffForm>((event, emit) {
      if (event.staffMember != null) {
        emit(
          state.copyWith(
            status: StaffFormStatus.editing,
            staffMember:
                event
                    .staffMember, // This should be a deep copy if StaffMember is mutable
            originalStaffMember: event.staffMember,
          ),
        );
      } else {
        // For new form, reset to initial state with empty staff member
        emit(StaffFormState.initial());
      }
    });

    on<NameChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(name: event.name),
        ),
      ),
    );
    on<MobileChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(mobile: event.mobile),
        ),
      ),
    );
    on<EmailChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(email: event.email),
        ),
      ),
    ); // Assuming StaffMember has email
    on<DepartmentChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            department: event.department ?? state.staffMember.department,
          ),
        ),
      ),
    );
    on<AcademicYearChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            academicYear: event.academicYear ?? state.staffMember.academicYear,
          ),
        ),
      ),
    ); // Assuming StaffMember has academicYear
    on<PermanentAddressChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(address: event.address),
        ),
      ),
    );
    on<EmployeeTypeChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(type: event.type),
        ),
      ),
    );
    on<HighestEducationChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            highestEducation: event.education,
          ),
        ),
      ),
    ); // Assuming StaffMember has highestEducation
    on<GradesChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(grades: event.grades),
        ),
      ),
    ); // Assuming StaffMember has grades
    on<AdharCardNumberChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(adharCardNumber: event.adhar),
        ),
      ),
    ); // Assuming StaffMember has adharCardNumber
    on<PancardNumberChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(pancardNumber: event.pan),
        ),
      ),
    ); // Assuming StaffMember has pancardNumber
    on<EmergencyMobileNumberChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            emergencyMobileNumber: event.emergencyMobile,
          ),
        ),
      ),
    ); // Assuming StaffMember has emergencyMobileNumber
    on<SalaryAmountChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(salaryAmount: event.salary),
        ),
      ),
    ); // Assuming StaffMember has salaryAmount
    on<PfDeductionChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(pfDeduction: event.pf),
        ),
      ),
    ); // Assuming StaffMember has pfDeduction
    on<BankAccountNumberChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            bankAccountNumber: event.bankAccount,
          ),
        ),
      ),
    ); // Assuming StaffMember has bankAccountNumber
    on<JoiningDateChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            joiningDate: event.joiningDate,
          ),
        ),
      ),
    ); // Assuming StaffMember has joiningDate
    on<RelivingDateChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            relivingDate: event.relivingDate,
          ),
        ),
      ),
    ); // Assuming StaffMember has relivingDate
    on<VerificationChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            status: event.verification ?? state.staffMember.status,
          ),
        ),
      ),
    ); // Map verification to status
    on<AnyMessageChanged>(
      (event, emit) => emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(anyMessage: event.message),
        ),
      ),
    ); // Assuming StaffMember has anyMessage

    on<UploadProfilePhoto>((event, emit) {
      // Simulate photo upload, update staffMember.imageUrl
      // In a real app, use image_picker, upload to server, get URL
      emit(
        state.copyWith(
          staffMember: state.staffMember.copyWith(
            imageUrl: "assets/images/new_profile_placeholder.png",
          ),
        ),
      );
      print("Profile photo upload triggered");
    });

    on<UploadIdProof>((event, emit) {
      // Simulate ID proof upload
      // In a real app, use file_picker, upload to server, store reference
      print("ID proof upload triggered");
    });

    on<SubmitStaffForm>((event, emit) async {
      emit(state.copyWith(status: StaffFormStatus.loading));
      // TODO: Add validation logic here
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      print("Form submitted for: ${state.staffMember.name}");
      // In a real app, you would save state.staffMember to a database/API
      // For now, just transition to success
      emit(state.copyWith(status: StaffFormStatus.success));
    });
  }
}
