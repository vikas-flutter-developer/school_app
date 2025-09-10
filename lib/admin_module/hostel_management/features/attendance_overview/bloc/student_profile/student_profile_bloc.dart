import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/student_profile_model.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class HostelStudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  HostelStudentProfileBloc() : super(StudentProfileInitial()) {
    on<LoadStudentProfile>((event, emit) async {
      emit(StudentProfileLoading());
      try {
        // Simulate API call based on event.studentId
        await Future.delayed(const Duration(seconds: 1));
        final StudentProfileModel profile = StudentProfileModel(
          roomSeat: "101- 1",
          name: "Mayuri Shah",
          profileImageUrl: "assets/images/profileimage.png",
          expiryDate: "02/03/25",
          email: "mayurishah@gmail.com",
          mobile: "+91 78869 56775",
          department: "Civil Enginnering",
          year: "1st Year",
          address: "56 colony, deep bunglow chowk,\nMysore , 466 879",
          parentName: "Priyanka Shah",
          parentRelation: "Mother",
          parentMobile: "+91 78869 56775",
          parentOccupation: "Housewife",
          advancePayment: "45,000/-",
          pendingPayment: "25,000/-",
          pendingDueDate: "5th April 2025",
          cautionMoney: "25,000/-",
          medicalConditions: "NA",
          allergies: "NA",
          phobias: "NA",
          doctorName: "Dr. Jayesh Mehta",
          doctorContact: "+91 98446 64759",
        );
        emit(StudentProfileLoaded(profile));
      } catch (e) {
        emit(StudentProfileError("Failed to load student profile"));
      }
    });
  }
}
