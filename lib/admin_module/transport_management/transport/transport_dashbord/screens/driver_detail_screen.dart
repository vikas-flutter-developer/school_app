import 'package:edudibon_flutter_bloc/admin_module/transport_management/transport/transport_dashbord/screens/trip_detail_screens.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_decorations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../data/driver_detail_model.dart';
import 'driver_management_screen.dart';

class DriverDetailScreen extends StatelessWidget {
  final Driver driver;

  const DriverDetailScreen({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    final List<Map<String, String>> assignedRoutes = [
      {'date': '2024-07-20', 'route': 'Route: Downtown - Suburbia'},
      {'date': '2024-07-21', 'route': 'Route: Suburbia - Downtown'},
    ];

    final TextStyle headingStyle = AppStyles.heading.copyWith(
      color: AppColors.black,
      fontSize: ScreenUtilHelper.fontSize(18), // <-- Scaled
    );

    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.height(30.0)), // <-- Scaled
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(12.0)), // <-- Scaled
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                        onPressed: () => GoRouter.of(context).pop(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20.0)), // <-- Scaled
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: ScreenUtilHelper.radius(50), // <-- Scaled
                                  backgroundImage: AssetImage(driver.avatarUrl),
                                ),
                                SizedBox(height: ScreenUtilHelper.height(16)), // <-- Scaled
                                Text(
                                  driver.name,
                                  style: AppStyles.display.copyWith(
                                    fontSize: ScreenUtilHelper.fontSize(24), // <-- Scaled
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  'Driver ID: ${driver.id}',
                                  style: AppStyles.body.copyWith(
                                    color: AppColors.stone,
                                    fontSize: ScreenUtilHelper.fontSize(16), // <-- Scaled
                                  ),
                                ),
                                Text(
                                  'Contact: ${driver.contact}',
                                  style: AppStyles.body.copyWith(
                                    color: AppColors.stone,
                                    fontSize: ScreenUtilHelper.fontSize(16), // <-- Scaled
                                  ),
                                ),
                                SizedBox(height: ScreenUtilHelper.height(10)), // <-- Scaled
                                OutlinedButton(
                                  onPressed: () =>context.push(AppRoutes.adminTripDetails),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: AppDecorations.smallRadius,
                                    ),
                                    side:  BorderSide(color: AppColors.silver),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Trip Detail',
                                        style: AppStyles.bodySmall.copyWith(
                                          color: AppColors.primary,
                                          fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
                                        ),
                                      ),
                                      SizedBox(width: ScreenUtilHelper.width(4)), // <-- Scaled
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: ScreenUtilHelper.scaleAll(14), // <-- Scaled
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ScreenUtilHelper.height(30)), // <-- Scaled
                          Padding(
                            padding: EdgeInsets.only(left: ScreenUtilHelper.width(20)), // <-- Scaled
                            child: Text('Assigned Vehicle', style: headingStyle),
                          ),
                          SizedBox(height: ScreenUtilHelper.height(8)), // <-- Scaled
                          _buildInfoCard(
                            icon: Icons.directions_bus,
                            details: ['Bus Model X', 'Vehicle ID: ${driver.vehicle}'],
                          ),
                          SizedBox(height: ScreenUtilHelper.height(20)), // <-- Scaled
                          Padding(
                            padding: EdgeInsets.only(left: ScreenUtilHelper.width(18.0)), // <-- Scaled
                            child: Text('License Information', style: headingStyle),
                          ),
                          SizedBox(height: ScreenUtilHelper.height(8)), // <-- Scaled
                          _buildInfoCard(
                            icon: Icons.credit_card,
                            details: [
                              'License No: ${driver.licenseNo}',
                              'Expires: ${driver.licenseExpiry.toLocal().toString().split(' ')[0]}'
                            ],
                          ),
                          SizedBox(height: ScreenUtilHelper.height(10)), // <-- Scaled
                          _buildRoutesCard(routes: assignedRoutes),
                          SizedBox(height: ScreenUtilHelper.height(10)), // <-- Scaled
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8)), // <-- Scaled
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.black,
                      size: ScreenUtilHelper.scaleAll(32), // <-- Scaled
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required List<String> details}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16)), // <-- Scaled
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8)), // <-- Scaled
            decoration: BoxDecoration(
              color: AppColors.cloud,
              borderRadius: AppDecorations.normalRadius,
            ),
            child: Icon(icon, color: AppColors.graphite, size: ScreenUtilHelper.scaleAll(28)), // <-- Scaled
          ),
          SizedBox(width: ScreenUtilHelper.width(10)), // <-- Scaled
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(details[0], style: AppStyles.headingS.copyWith(fontSize: ScreenUtilHelper.fontSize(16))), // <-- Scaled
                SizedBox(height: ScreenUtilHelper.height(2)), // <-- Scaled
                Text(
                  details[1],
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.slate,
                    fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesCard({required List<Map<String, String>> routes}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(18.0)), // <-- Scaled
          child: Text(
            'Assigned Routes',
            style: AppStyles.heading.copyWith(
              color: AppColors.black,
              fontSize: ScreenUtilHelper.fontSize(18), // <-- Scaled
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(12)), // <-- Scaled
        ...routes.map((route) {
          return Container(
            margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)), // <-- Scaled
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16), // <-- Scaled
              vertical: ScreenUtilHelper.height(12), // <-- Scaled
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(8)), // <-- Scaled
                  decoration: BoxDecoration(
                    color: AppColors.cloud,
                    borderRadius: AppDecorations.normalRadius,
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.graphite,
                    size: ScreenUtilHelper.scaleAll(24), // <-- Scaled
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(12)), // <-- Scaled
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route['date']!,
                        style: AppStyles.bodyEmphasis.copyWith(fontSize: ScreenUtilHelper.fontSize(14)), // <-- Scaled
                      ),
                      Text(
                        route['route']!,
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.slate,
                          fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}