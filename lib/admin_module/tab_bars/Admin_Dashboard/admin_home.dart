// Your updated dashboard_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../student_module/tab_bars&notifications/notification_screen.dart';
import '../../../widgets/dashboard_card.dart';
import '../data/dashboard_data.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper (best practice is in MaterialApp's build method)
    //ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old fixed values. All sizing is now done with the helper.
    final double cardAspectRatio = 0.9; // Aspect ratio is a ratio, so it's fine as is.

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/edudibon_logo.png',
                  height: ScreenUtilHelper.height(30),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: AppColors.black),
                  onPressed: ()=>context.push(AppRoutes.notifications),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
        ),
        body: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardNavigating) {
              context.push(state.routeName);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              // ✅ Use helper for consistent padding
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Search Bar Area ---
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
                    decoration: BoxDecoration(
                      color: AppColors.parchment,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                    ),
                    child: Row(
                      children: [
                         Icon(Icons.search, color: AppColors.slate),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              isDense: true,
                              hintStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), color: AppColors.ash),
                              contentPadding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(12)),
                            ),
                            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), color: AppColors.black),
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.width(8)),
                         Icon(Icons.mic, color: AppColors.slate),
                        SizedBox(width: ScreenUtilHelper.width(4)),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(24)),

                  // --- Build Sections and Grids ---
                  ...dashboardSections.map((section) {
                    final List<DashboardItem> items = (section['items'] as List?)?.cast<DashboardItem>() ?? [];
                    final String title = section['title'] as String? ?? 'Unnamed Section';

                    if (items.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(18),
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackHighEmphasis,
                          ),
                        ),
                        SizedBox(height: ScreenUtilHelper.height(16)),
                        GridView.extent(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // ✅ Use helper for responsive grid dimensions
                          maxCrossAxisExtent: ScreenUtilHelper.width(150),
                          crossAxisSpacing: ScreenUtilHelper.width(12),
                          mainAxisSpacing: ScreenUtilHelper.height(12),
                          childAspectRatio: cardAspectRatio,
                          children: items.map<Widget>((item) {
                            return DashboardCard(
                              onTap: () {
                                if (item.routeName != null && item.routeName!.isNotEmpty) {
                                  context.read<DashboardBloc>().add(CardTapped(item: item));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("'${item.title}' is not yet implemented.")),
                                  );
                                }
                              }, title: item.title, icon: item.icon,
                            );

                          }).toList(),
                        ),
                        SizedBox(height: ScreenUtilHelper.height(24)),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}