import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ✅ import ScreenUtilHelper
import '../../widgets/Custom_logo_appbar.dart';
import '../../widgets/admin_details_section.dart';
//import '../../widgets/staff_Profile_Header.dart';
//import 'approve_submit.dart';
import '../../widgets/personal_details_section.dart';
import '../../widgets/staffProfileHeader.dart';
import '../../widgets/staff_dcument_section.dart';
import '../../widgets/staff_salary_details_section.dart';
import '../bloc/staff_form_bloc.dart';
import '../bloc/staff_form_event.dart';
import '../bloc/staff_form_state.dart';
import '../model/staff_form_model.dart';

class StaffFormScreen extends StatelessWidget {
  const StaffFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StaffFormBloc()..add(LoadStaffFormData()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomLogoAppBar(
          onBackPressed: () => GoRouter.of(context).pop(),
          notificationCount: 1,
        ),
        body: BlocConsumer<StaffFormBloc, StaffFormState>(
          listener: (context, state) {
            if (state is StaffFormSubmitSuccess) {
              context.push(AppRoutes.employeeProfileCreated);
            } else if (state is StaffFormSubmitFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            StaffFormModel? form;
            if (state is StaffFormLoaded) {
              form = state.form;
            } else if (state is StaffFormInitial) {
              form = state.form;
            }

            return form == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const StaffProfileHeader(),
                    SizedBox(height: ScreenUtilHelper.height(8)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                        vertical: ScreenUtilHelper.height(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Details',
                            style: AppStyles.sectionHeading.copyWith(
                              fontSize: ScreenUtilHelper.fontSize(18),
                            ),
                          ),
                          Text(
                            'Inquiry Form',
                            style: AppStyles.bodySmall.copyWith(
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: ScreenUtilHelper.height(12)),

                    PersonalDetailsSection(form: form),

                    DocumentsSection(
                      form: form,
                      onFieldChanged: (field, value) {
                        context.read<StaffFormBloc>().add(
                          StaffFormFieldChanged(field, value),
                        );
                      },
                    ),

                    SizedBox(height: ScreenUtilHelper.height(16)),

                    SalaryDetailsSection(form: form),

                    SizedBox(height: ScreenUtilHelper.height(12)),

                    AdminDetailsSection(form: form),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: AppColors.selected,
          unselectedItemColor: AppColors.iconGray,
          selectedFontSize: ScreenUtilHelper.fontSize(12),
          unselectedFontSize: ScreenUtilHelper.fontSize(12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              activeIcon: Icon(Icons.article),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'My Account',
            ),
          ],
        ),
      ),
    );
  }
}
