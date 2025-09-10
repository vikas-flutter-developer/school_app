// Your updated admin_profile_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../widgets/logout_confirmation_dialog.dart';
import '../data/admin_profile_data.dart';
import 'Change_Password/bloc/change_password_bloc.dart';
import 'Change_Password/enter_user_id_screen.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  // --- Helper: Build Detail Row (Now Responsive) ---
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    // ✅ Use helper for all sizes
    final double fontSize = ScreenUtilHelper.fontSize(14);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(112), // Approx 30% of base width (375)
            child: Text(
              label,
              style: GoogleFonts.openSans(
                fontSize: fontSize,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtilHelper.width(15),
            child: Text(
              ":",
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.openSans(
                fontSize: fontSize,
                color: AppColors.black,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper (best practice is in MaterialApp's build method)
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery logic.

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOutSuccess) {
          // Navigate on success
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Operation Failed: ${state.message}'),
                backgroundColor: AppColors.errorAccent,
              ),
            );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.blackMediumEmphasis, size: ScreenUtilHelper.scaleAll(20)),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            'Admin Profile',
            style: GoogleFonts.openSans(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.fontSize(16),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis),
              onPressed: () {},
            ),
            SizedBox(width: ScreenUtilHelper.width(5)),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            AdminProfileData profileData = dummyAdminProfileData;
            if (state is ProfileLoaded) {
              profileData = state.profileData;
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(19),
                  vertical: ScreenUtilHelper.height(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- Profile Header ---
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtilHelper.height(20),
                        horizontal: ScreenUtilHelper.width(15),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: ScreenUtilHelper.scaleAll(38),
                            backgroundColor: AppColors.cloud,
                            // backgroundImage: (profileData.profileImageUrl != null && profileData.profileImageUrl!.startsWith('http'))
                            //     ? NetworkImage(profileData.profileImageUrl!)
                            //     : (profileData.profileImageUrl != null
                            //     ? AssetImage(profileData.profileImageUrl!) as ImageProvider
                            //     : const AssetImage('assets/images/profile.png')),
                            backgroundImage: AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(width: ScreenUtilHelper.width(15)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileData.name,
                                  style: GoogleFonts.openSans(
                                    fontSize: ScreenUtilHelper.fontSize(16),
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(height: ScreenUtilHelper.height(4)),
                                Text(
                                  profileData.designation,
                                  style: GoogleFonts.openSans(
                                    fontSize: ScreenUtilHelper.fontSize(16),
                                    color: AppColors.primaryDarkAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(25)),

                    // --- Profile Details ---
                    _buildDetailRow(context, 'Status', profileData.status),
                    _buildDetailRow(context, 'DOB', profileData.dob),
                    _buildDetailRow(context, 'Email Id', profileData.email),
                    _buildDetailRow(context, 'Mobile number', profileData.mobile),
                    _buildDetailRow(context, 'Blood Group', profileData.bloodGroup),
                    _buildDetailRow(context, 'Gender', profileData.gender),
                    _buildDetailRow(context, 'Address', profileData.address),

                    SizedBox(height: ScreenUtilHelper.height(40)),

                    // --- Action Buttons ---
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (context) => ChangePasswordBloc(),
                              child: const EnterUserIdScreen(),
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryMedium,
                        side: const BorderSide(color: AppColors.primaryMedium, width: 1.5),
                        padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(14)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(30))),
                      ),
                      child: Text(
                        'Change password',
                        style: GoogleFonts.openSans(
                          fontSize: ScreenUtilHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(15)),
                    OutlinedButton(
                      onPressed: () async {
                        final bool? confirmLogout = await showLogoutConfirmationDialog(context);
                        if (confirmLogout == true) {
                          context.read<ProfileBloc>().add(LogoutRequested());
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryMedium,
                        side: const BorderSide(color: AppColors.primaryMedium, width: 1.5),
                        padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(14)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(30))),
                      ),
                      child: Text(
                        'Logout',
                        style: GoogleFonts.openSans(
                          fontSize: ScreenUtilHelper.fontSize(16),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(20)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}