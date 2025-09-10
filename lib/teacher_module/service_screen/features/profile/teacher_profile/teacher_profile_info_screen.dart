import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../teacher_edit_profile/screens/edit_profile_screen.dart';
import 'bloc/teacher_bloc.dart';
import 'model/teacher_models.dart';

class TeacherProfileInfoScreen extends StatelessWidget {
  const TeacherProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ScreenUtilHelper
    return BlocProvider(
      create: (context) => TeacherBloc()..add(TeacherFetchEvent()),
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: AppBar(
          backgroundColor: Color(0xffFFFFFF),
          title: Text(
            "Teacher Profile",
            style: TextStyle(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.display), // ScreenUtilHelper

              fontWeight: AppStyles.weight.strong,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // GoRouter.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_rounded),
              onPressed: () {
                // Handle notifications
              },
            ),
          ],
        ),
        body: BlocBuilder<TeacherBloc, TeacherState>(
          builder: (context, state) {
            if (state is TeacherInitial || state is TeacherLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TeacherLoadedState) {
              return _buildStudentProfile(context, state.teacherModel);
            } else if (state is TeacherErrorState) {
              return Center(child: Text("Error: ${state.errorMassage}"));
            } else {
              return Center(
                child: Text("Unknown state"),
              ); // Handle unexpected states
            }
          },
        ),
      ),
    );
  }

  Widget _buildStudentProfile(BuildContext context, TeacherModels teacher) {
    void logout() {
      // Show confirmation dialog before logging out
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  GoRouter.of(dialogContext).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text(
                  'Log Out',
                  style: TextStyle(color: AppColors.errorAccent),
                ),
                onPressed: () {
                  GoRouter.of(dialogContext).pop(); // Close the dialog

                  // Listener in main.dart or wrapper should handle navigation
                },
              ),
            ],
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // ScreenUtilHelper

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtilHelper.width(398), // ScreenUtilHelper
              height: ScreenUtilHelper.height(162), // ScreenUtilHelper

              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(4)), // ScreenUtilHelper
              decoration: BoxDecoration(
                color: Color(0xffF8F9FE), // Light purple background
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // ScreenUtilHelper

              ),
              child: SizedBox(
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: ScreenUtilHelper.width(61.55), // ScreenUtilHelper
                          height: ScreenUtilHelper.height(60), // ScreenUtilHelper
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: ScreenUtilHelper.radius(60), // ScreenUtilHelper

                              backgroundImage: NetworkImage(
                                teacher.data.dataClass.subjects[0].staffImage,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              teacher.data.name,
                              style: TextStyle(
                                fontSize: ScreenUtilHelper.fontSize(AppStyles.size.body), // ScreenUtilHelper

                                fontWeight:AppStyles.weight.strong,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                spacing: 2,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Class: ${teacher.data.dataClass.name}",
                                    style: TextStyle(
                                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper

                                      color: AppColors.tertiaryAccent,
                                    ),
                                  ),
                                  _buildVerticalDivider(high: ScreenUtilHelper.height(10)), // ScreenUtilHelper

                                  Text(
                                    "Roll no: ${teacher.data.rollNumber}",
                                    style: TextStyle(
                                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper
                                      color: AppColors.info,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: ()=>context.go(AppRoutes.teacherEditProfile),
                          icon: Icon(Icons.edit, size: ScreenUtilHelper.scaleAll(16)), // ScreenUtilHelper

                        ),
                      ],
                    ),
                    _buildStatsRow(
                      grade: null,
                      totalAttendance: null,
                      timeOff: null,
                    ),

                    SizedBox(height: ScreenUtilHelper.height(24)), // ScreenUtilHelper

                  ],
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(16)), // ScreenUtilHelper

            _buildInformation(
              fatherName:
                  teacher.data.fatherId.toString() != '[]'
                      ? teacher.data.fatherId.toString()
                      : 'N/A',
              className: teacher.data.dataClass.name,
              attendance: null,
              dob: teacher.data.dob.toString(),
              email: null,
              mobileNumber: null,
              bloodGroup: teacher.data.bloodGroup,
              gender: teacher.data.gender,
              status: teacher.status,
              admissionYear: teacher.data.dataClass.academicYearId[1],
              admissionNumber: teacher.data.admissionNumber,
              admissionDate: teacher.data.admittedDate,
              scholarNumber: null,
              address: null,
            ),
            SizedBox(height: ScreenUtilHelper.height(16)), // ScreenUtilHelper

            GestureDetector(
              onTap: () {
                logout();
              },
              child: Container(
                height: ScreenUtilHelper.height(30), // ScreenUtilHelper

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)), // ScreenUtilHelper

                  border: Border.all(color: AppColors.primaryMedium),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.body), // ScreenUtilHelper
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

  Widget _buildStatsRow({
    required int? grade,
    required int? totalAttendance,
    required int? timeOff,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(
          title: "Grade",
          value: grade != null ? grade.toString() : "N/A",
        ),
        _buildVerticalDivider(high: ScreenUtilHelper.height(40)), // ScreenUtilHelper

        _buildStatColumn(
          title: "Total attendance",
          value: totalAttendance != null ? "$totalAttendance%" : "N/A",
        ),
        _buildVerticalDivider(high: ScreenUtilHelper.height(40)), // ScreenUtilHelper

        _buildStatColumn(
          title: "Time off",
          value: timeOff != null ? timeOff.toString() : "N/A",
        ),
      ],
    );
  }

  Widget _buildStatColumn({required String title, required String value}) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
            color: AppColors.info)),
        Text(
          value,
          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
              fontWeight:AppStyles.weight.heading),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider({required double high}) {
    return Container(height: ScreenUtilHelper.height(high), width: 2, color: AppColors.blackDisabled); // ScreenUtilHelper

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
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8.0)), // ScreenUtilHelper

      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowInformation(title: "Father Name", value: fatherName),
          _buildRowInformation(title: "Class Name", value: className),
          _buildRowInformation(
            title: "Attendance",
            value: attendance.toString(),
          ),
          _buildRowInformation(title: "DOB", value: dob.toString()),
          _buildRowInformation(title: "Email", value: email),
          _buildRowInformation(title: "Mobile Number", value: mobileNumber),
          _buildRowInformation(title: "Blood Group", value: bloodGroup),
          _buildRowInformation(title: "Gender", value: gender),
          _buildRowInformation(title: "Status", value: status),
          _buildRowInformation(title: "Admission Year", value: admissionYear),
          _buildRowInformation(
            title: "Admission Number",
            value: admissionNumber,
          ),
          _buildRowInformation(title: "Admission Date", value: admissionDate),
          _buildRowInformation(title: "Scholar Number", value: scholarNumber),
          _buildRowInformation(title: "Address", value: address),
        ],
      ),
    );
  }

  Widget _buildRowInformation({required String title, required String? value}) {
    return Row(
      children: [
        SizedBox(
          width: ScreenUtilHelper.width(150), // ScreenUtilHelper

          child: Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

              fontWeight: AppStyles.weight.regular,
            ),
          ),
        ),
        SizedBox(
          width: ScreenUtilHelper.width(4), // ScreenUtilHelper
          height: ScreenUtilHelper.height(19), // ScreenUtilHelper

          child: Text(
            ":",
            style: TextStyle(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

              fontWeight:AppStyles.weight.regular,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(4.0)), // ScreenUtilHelper

          child: Text(
            value != null ? value.toString() : "N/A",
            style: TextStyle(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper

              fontWeight: AppStyles.weight.regular,
            ),
          ),
        ),
      ],
    );
  }
}
