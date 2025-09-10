// screens/master_data_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';
import '../../routes/app_routes.dart';
import 'admission_dashboard_screen.dart';
import 'bloc/master_data_bloc.dart';
import 'student_staff_details_screen.dart';

class MasterDataScreen extends StatelessWidget {
  const MasterDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MasterDataBloc(),
      child: const MasterDataView(),
    );
  }
}

class MasterDataView extends StatelessWidget {
  const MasterDataView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context),
              SizedBox(height: ScreenUtilHelper.height(24)),
              Image.asset(
                'assets/images/master_data.png',
                height: ScreenUtilHelper.height(240),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  size: ScreenUtilHelper.height(120),
                  color: AppColors.ash,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(24)),
              _buildActionButton(
                context: context,
                text: 'Student/ Staff Details',
                onPressed: () => context.push(AppRoutes.studentStaffDetails),
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),
              _buildActionButton(
                context: context,
                text: 'Admission Dashboard',
                onPressed: () => context.push(AppRoutes.masterDataDetails),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: ScreenUtilHelper.width(14),
      title: Image.asset(
        'assets/images/edudibon1.png',
        height: ScreenUtilHelper.height(28),
        errorBuilder: (context, error, stackTrace) => const Text(
          'Logo',
          style: TextStyle(color: AppColors.error, fontSize: 16),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: AppColors.blackMediumEmphasis),
          onPressed: () {},
        ),
        SizedBox(width: ScreenUtilHelper.width(8)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.height(12)),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.blackHighEmphasis),
            onPressed: () => GoRouter.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
          Text(
            'Master Data',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.fontSize(16),
              color: AppColors.blackHighEmphasis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtilHelper.height(50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
          ),
          elevation: 2.0,
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: ScreenUtilHelper.fontSize(14),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} // End MasterDataView
