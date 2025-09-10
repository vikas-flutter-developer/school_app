import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/route_bloc.dart';
import '../bloc/route_event.dart';
import '../bloc/route_state.dart';
import 'add_route_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (_) => RouteBloc()..add(LoadRoutes()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _CustomLogoAppBar(),
        body: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: ScreenUtilHelper.scaleAll(20),
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Route management",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),
              SizedBox(
                height: 56,
                width: 358,
                child: TextField(
                  onChanged: (value) {
                    context.read<RouteBloc>().add(SearchRoutes(value));
                  },
                  style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                  decoration: InputDecoration(
                    hintText: "Search routes",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtilHelper.fontSize(14),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.radius(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ScreenUtilHelper.height(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),
              Row(
                children: [
                  Container(
                    height: 32,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF0F2F5),
                    ),
                    child: Center(
                      child: Text(
                        "Sort by Name",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(12),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(15)),
                  Container(
                    height: 32,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF0F2F5),
                    ),
                    child: Center(
                      child: Text(
                        "Sort by distance",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(12),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(15)),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(14),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.radius(12),
                          ),
                        ),
                      ),
                      onPressed: ()=>context.push(AppRoutes.addRoute),
                      child: Text(
                        "Add Route",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(12),
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(16)),

              Expanded(
                child: BlocBuilder<RouteBloc, RouteState>(
                  builder: (context, state) {
                    if (state is RouteLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RouteLoaded) {
                      if (state.routes.isEmpty) {
                        return Center(
                          child: Text(
                            "No routes found",
                            style: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(14),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.routes.length,
                        itemBuilder: (context, index) {
                          final route = state.routes[index];
                          return Container(
                            height: 96,
                            width: 390,
                            margin: EdgeInsets.only(
                              bottom: ScreenUtilHelper.height(12),
                            ),
                            padding: EdgeInsets.all(ScreenUtilHelper.width(12)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                ScreenUtilHelper.radius(12),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        route.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtilHelper.fontSize(18),
                                        ),
                                      ),
                                      SizedBox(height: ScreenUtilHelper.height(4)),
                                      Text(
                                        "${route.stops} stops | ${route.distance} km | ${route.duration} min",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ScreenUtilHelper.fontSize(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.radius(12),
                                  ),
                                  child: Image.asset(
                                    route.image,
                                    width: ScreenUtilHelper.width(100),
                                    height: ScreenUtilHelper.height(64),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
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

class _CustomLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final int notificationCount;

  const _CustomLogoAppBar({
    Key? key,
    this.onBackPressed,
    this.notificationCount = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(12),
          vertical: ScreenUtilHelper.height(10),
        ),
        color: AppColors.white,
        child: Row(
          children: [
            // IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios,
            //     size: ScreenUtilHelper.scaleAll(22),
            //   ),
            //   onPressed: onBackPressed ?? () => GoRouter.of(context).pop(),
            // ),
            SizedBox(width: ScreenUtilHelper.width(6)),
            Image.asset(
              'assets/images/edudibon_logo.png',
              height: ScreenUtilHelper.height(39),
              width: ScreenUtilHelper.width(159),
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Stack(
              children: [
                Icon(Icons.notifications_outlined,color: AppColors.black,size: ScreenUtilHelper.scaleAll(32),),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: ScreenUtilHelper.scaleAll(14),
                      height: ScreenUtilHelper.scaleAll(14),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          notificationCount.toString(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: ScreenUtilHelper.fontSize(9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + ScreenUtilHelper.height(20));
}
