import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/student_profile/student_profile_bloc.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/profile_header_card_widget.dart';
import '../widgets/profile_info_row_widget.dart';
import '../widgets/profile_payments_card_widget.dart';
import '../widgets/profile_section_card_widget.dart';

class HostelProfileScreen extends StatelessWidget {
  const HostelProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: const CommonBar(),
      body: BlocBuilder<HostelStudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state is StudentProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentProfileLoaded) {
            final profile = state.profile;
            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeaderCardWidget(profile: profile),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  ProfileSectionCardWidget(
                    title: "Student Profile",
                    children: [
                      ProfileInfoRowWidget(
                        "Name - ${profile.email}",
                      ),
                      ProfileInfoRowWidget("Mobile- ${profile.mobile}"),
                      ProfileInfoRowWidget(
                        "Department - ${profile.department}",
                      ),
                      ProfileInfoRowWidget("Year - ${profile.year}"),
                      ProfileInfoRowWidget("Address- ${profile.address}"),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  ProfileSectionCardWidget(
                    title: "Parent / Guardian",
                    children: [
                      ProfileInfoRowWidget("Name - ${profile.parentName}"),
                      ProfileInfoRowWidget(
                        "Relation - ${profile.parentRelation}",
                      ),
                      ProfileInfoRowWidget("Mobile - ${profile.parentMobile}"),
                      ProfileInfoRowWidget(
                        "Occupation - ${profile.parentOccupation}",
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  ProfilePaymentsCardWidget(profile: profile),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                  ProfileSectionCardWidget(
                    title: "Medical History",
                    children: [
                      ProfileInfoRowWidget(
                        "Medical Conditions - ${profile.medicalConditions}",
                      ),
                      ProfileInfoRowWidget("Allergies - ${profile.allergies}"),
                      ProfileInfoRowWidget("Phobias - ${profile.phobias}"),
                      ProfileInfoRowWidget(profile.doctorName),
                      ProfileInfoRowWidget(profile.doctorContact),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.height(20)),
                ],
              ),
            );
          }
          if (state is StudentProfileError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Please load profile."));
        },
      ),
    );
  }
}