import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Date formatting के लिए इम्पोर्ट
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_decorations.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../student_profile/bloc/student_bloc.dart';
import '../model/student_models.dart';

class StudentProfileInfoScreen extends StatelessWidget {
  const StudentProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc()..add(StudentFetchEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "Student Profile",
            style: TextStyle(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
              fontWeight: AppStyles.weight.heading,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentInitial || state is StudentLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentLoadedState) {
              return _buildStudentProfile(context, state.studentModel);
            } else if (state is StudentErrorState) {
              return Center(child: Text("Error: ${state.errorMassage}"));
            } else {
              return const Center(child: Text("Unknown state"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildStudentProfile(BuildContext context, StudentModels student) {
    void logout() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CupertinoAlertDialog(
            title: const Text('Log out', style: TextStyle(color: Colors.black)),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  GoRouter.of(dialogContext).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text('Log out', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  GoRouter.of(dialogContext).pop();
                  context.go(AppRoutes.otpConfirmation);
                },
              ),
            ],
          );
        },
      );
    }

    // DOB को फॉर्मेट करें
    final formattedDob = DateFormat('dd/MM/yyyy').format(student.data.dob);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
              decoration: BoxDecoration(
                color: AppColors.ivory,
                borderRadius: AppDecorations.normalRadius,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: ScreenUtilHelper.scaleRadius(30),
                        backgroundImage: const AssetImage(
                          'assets/images/profile.jpg',
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student.data.name, style: AppStyles.bodyEmphasis),
                            Row(
                              children: [
                                Text(
                                  "Class: ${student.data.dataClass.name}",
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                                    color: AppColors.primary,
                                  ),
                                ),
                                _buildVerticalDivider(high: ScreenUtilHelper.scaleHeight(10)),
                                Text(
                                  "Roll no: ${student.data.rollNumber}",
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small),
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.go(AppRoutes.studentEditProfile),
                        icon: const Icon(Icons.edit, size: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  _buildStatsRow(
                      grade: student.data.grade,
                      totalAttendance: student.data.attendance,
                      timeOff: student.data.timeOff),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            _buildInformation(
              fatherName: student.data.fatherName,
              className: student.data.dataClass.name,
              attendance: student.data.attendance,
              dob: formattedDob,
              email: student.data.email,
              mobileNumber: student.data.mobileNumber,
              bloodGroup: student.data.bloodGroup,
              gender: student.data.gender,
              status: student.data.status,
              admissionYear: student.data.dataClass.academicYearId[1],
              admissionNumber: student.data.admissionNumber,
              admissionDate: student.data.admittedDate,
              scholarNumber: student.data.scholarNumber,
              address: student.data.address,
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            GestureDetector(
              onTap: logout,
              child: Container(
                height: ScreenUtilHelper.scaleHeight(40),
                decoration: BoxDecoration(
                  borderRadius: AppDecorations.mediumRadius,
                  border: Border.all(color: AppColors.primaryMedium),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
                      color: AppColors.primaryMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow({required int? grade, required int? totalAttendance, required int? timeOff}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(title: "Grade", value: grade?.toString() ?? "10"),
        _buildVerticalDivider(high: ScreenUtilHelper.scaleHeight(40)),
        _buildStatColumn(title: "Total attendance", value: totalAttendance != null ? "$totalAttendance%" : "81%"),
        _buildVerticalDivider(high: ScreenUtilHelper.scaleHeight(40)),
        _buildStatColumn(title: "Time off", value: timeOff?.toString() ?? "4"),
      ],
    );
  }

  Widget _buildStatColumn({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall),
            color: AppColors.primary,
          ),
        ),
        Text(value, style: AppStyles.bodySmallBold),
      ],
    );
  }

  Widget _buildVerticalDivider({required double high}) {
    return Container(
      height: high,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 1,
      color: AppColors.blackMediumEmphasis.withOpacity(0.5),
    );
  }

  Widget _buildInformation({
    required String? fatherName,
    required String? className,
    required int? attendance,
    required String? dob,
    required String? email,
    required String? mobileNumber,
    required String? bloodGroup,
    required String? gender,
    required String? status,
    required String? admissionYear,
    required String? admissionNumber,
    required String? admissionDate,
    required String? scholarNumber,
    required String? address,
  }) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowInformation(title: "Father Name", value: fatherName),
          _buildRowInformation(title: "Class", value: className),
          _buildRowInformation(title: "Attendance", value: attendance != null ? "$attendance%" : null),
          _buildRowInformation(title: "DOB", value: dob),
          _buildRowInformation(title: "Email Id", value: email),
          _buildRowInformation(title: "Mobile number", value: mobileNumber),
          _buildRowInformation(title: "Blood Group", value: bloodGroup),
          _buildRowInformation(title: "Gender", value: gender),
          _buildRowInformation(title: "Status", value: status),
          _buildRowInformation(title: "Admission year", value: admissionYear),
          _buildRowInformation(title: "Admission number", value: admissionNumber),
          _buildRowInformation(title: "Date of admission", value: admissionDate),
          _buildRowInformation(title: "Scholar number", value: scholarNumber),
          _buildRowInformation(title: "Address", value: address),
        ],
      ),
    );
  }

  Widget _buildRowInformation({required String title, required String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtilHelper.scaleWidth(140),
            child: Text(
              title,
              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
            ),
          ),
          Text(
            ":",
            style: AppStyles.bodySmall.copyWith(color: AppColors.black),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}