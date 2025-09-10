
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../staff_management/screens/Dashboard.dart';
import '../bloc/payroll_bloc.dart';
import '../bloc/payroll_event.dart';
import '../bloc/payroll_state.dart';

class PayrollScreenContent extends StatefulWidget {
  const PayrollScreenContent({super.key});

  @override
  State<PayrollScreenContent> createState() => _PayrollScreenContentState();
}

class _PayrollScreenContentState extends State<PayrollScreenContent> {
  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (_) => PayrollBloc()..add(LoadPayroll()),
      child: BlocBuilder<PayrollBloc, PayrollState>(
        builder: (context, state) {
          if (state is PayrollLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is PayrollError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }
          if (state is PayrollLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                  onPressed: () {
                    GoRouter.of(context).pop(); // Pop current screen
                  },
                ),
                title: Image.asset(
                  'assets/images/edudibon_logo.png',
                  width: ScreenUtilHelper.width(100),
                  height: ScreenUtilHelper.height(50),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, color: AppColors.blackHighEmphasis),
                    onPressed: () {},
                  )
                ],
              ),

              body: SingleChildScrollView(
                padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.parchment,
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.radius(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.blackHighEmphasis), // or any contrasting color
                          SizedBox(width: ScreenUtilHelper.width(8)),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic, color: AppColors.blackHighEmphasis),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),

                    // Rectangular segmented bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.width(12),
                        vertical: ScreenUtilHelper.height(8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.parchment, // Softer than primaryLighter
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.radius(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Teaching",
                            style: TextStyle(
                              color: AppColors.primaryMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                          ),
                          Container(
                            height: ScreenUtilHelper.height(16),
                            width: ScreenUtilHelper.width(1),
                            color: AppColors.ash,
                          ),
                          Text(
                            "Non Teaching",
                            style: TextStyle(
                              color: AppColors.primaryMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                          ),
                          Container(
                            height: ScreenUtilHelper.height(16),
                            width: ScreenUtilHelper.width(1),
                            color: AppColors.ash,
                          ),
                          Text(
                            "Administration",
                            style: TextStyle(
                              color: AppColors.primaryMedium,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtilHelper.fontSize(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(16)),

                    // Payroll Cards
                    _buildPayrollCard(name: "Manisha shah", month: "March 2025"),
                    SizedBox(height: ScreenUtilHelper.height(12)),
                    _buildPayrollCard(name: "Manish More", month: "March 2025"),
                    SizedBox(height: ScreenUtilHelper.height(12)),
                    _buildPayrollCard(name: "Meghna Pratap", month: "March 2025"),
                  ],
                ),
              ),
            );
          }

          return const SizedBox(); // fallback
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(8),
        horizontal: ScreenUtilHelper.width(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryMedium,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontSize: ScreenUtilHelper.fontSize(12),
        ),
      ),
    );
  }

  Widget _buildPayrollCard({
    required String name,
    required String month,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
        border: Border.all(color: AppColors.cloud),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtilHelper.height(8),
              horizontal: ScreenUtilHelper.width(12),
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryMedium,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtilHelper.radius(12)),
                topRight: Radius.circular(ScreenUtilHelper.radius(12)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtilHelper.fontSize(13),
                  ),
                ),
                Text(
                  month,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ScreenUtilHelper.fontSize(12),
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Sub-Department", "Primary"),
                _buildDetailRow("Joining Date", "12/02/25"),
                _buildDetailRow("Salary", "view breakdown", isLink: true),
                _buildDetailRow("Working Days", "28"),
                _buildDetailRow("Total Credited", "37,674/-"),
                _buildDetailRow("PF Deducted", "1,674/-"),
                _buildDetailRow("Receipt", "Download here", isLink: true),
                SizedBox(height: ScreenUtilHelper.height(4)),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: ()=>context.push(AppRoutes.payrollDetails),
                    child: Text(
                      "More",
                      style: TextStyle(
                        color: AppColors.primaryMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtilHelper.fontSize(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isLink = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(3),
      ),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtilHelper.width(120),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.blackMediumEmphasis,
                fontSize: ScreenUtilHelper.fontSize(12),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isLink ? AppColors.primaryMedium : AppColors.blackHighEmphasis,
                fontSize: ScreenUtilHelper.fontSize(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
