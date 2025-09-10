import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/driver_bloc/driver_bloc.dart';
import '../bloc/driver_bloc/driver_event.dart';
import '../bloc/driver_bloc/driver_state.dart';
import '../data/driver_detail_model.dart';
import 'driver_detail_screen.dart';

class DriverManagementScreen extends StatelessWidget {
  const DriverManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => DriverBloc()..add(FetchDrivers()),
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtilHelper.height(30.0)), // <-- Scaled
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
              onPressed: () => Navigator.of(context).pop(
                // MaterialPageRoute(builder: (context)=> MainScreen()),
              ),
            ),
            title: Text(
              "Driver Management",
              style: AppStyles.display.copyWith(
                fontSize: ScreenUtilHelper.fontSize(24), // <-- Scaled
                fontWeight: AppStyles.weight.emphasis,
                color: AppColors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: AppColors.black,
                  size: ScreenUtilHelper.scaleAll(30), // <-- Scaled
                ),
                onPressed: () {
                  // Handle notification tap
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // <-- Scaled
                child: TextField(
                  onChanged: (value) {
                    context.read<DriverBloc>().add(SearchDriver(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name or ID',
                    hintStyle: AppStyles.hint.copyWith(
                      fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(30)), // <-- Scaled
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.parchment,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<DriverBloc, DriverState>(
                  builder: (context, state) {
                    if (state is DriverLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DriverLoaded) {
                      if (state.drivers.isEmpty) {
                        return Center(
                          child: Text(
                            'No drivers found.',
                            style: AppStyles.body.copyWith(
                              color: AppColors.ash,
                              fontSize: ScreenUtilHelper.fontSize(16), // <-- Scaled
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.drivers.length,
                        itemBuilder: (context, index) {
                          final driver = state.drivers[index];
                          return DriverListItem(driver: driver);
                        },
                      );
                    }
                    if (state is DriverError) {
                      return Center(child: Text(state.message, style: AppStyles.errorMessage));
                    }
                    return const Center(child: Text('Please wait...'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DriverListItem extends StatelessWidget {
  final Driver driver;

  const DriverListItem({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: ScreenUtilHelper.radius(30), // <-- Scaled
        backgroundImage: AssetImage(driver.avatarUrl),
      ),
      title: Text(
        driver.name,
        style: AppStyles.bodyEmphasis.copyWith(
          fontSize: ScreenUtilHelper.fontSize(16), // <-- Scaled
        ),
      ),
      subtitle: Text(
        'ID: ${driver.id} | Vehicle: ${driver.vehicle}',
        style: AppStyles.bodyMedium.copyWith(
          fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: ScreenUtilHelper.scaleAll(20), // <-- Scaled
      ),
      onTap: () =>context.push(AppRoutes.adminDriverDetails,extra: driver),
      // {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DriverDetailScreen(driver: driver),
      //     ),
      //   );
      // },
    );
  }
}