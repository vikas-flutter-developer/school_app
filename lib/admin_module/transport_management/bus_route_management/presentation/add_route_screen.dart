import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/add_route_bloc.dart';
import '../bloc/add_route_event.dart';
import '../bloc/add_route_state.dart';
import 'add_route_confirm_screen.dart';

class AddRouteScreen extends StatelessWidget {
  const AddRouteScreen({super.key});

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      filled: true,
      fillColor: const Color(0xFFF0F2F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (_) => AddRouteBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _CustomLogoAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: BlocBuilder<AddRouteBloc, AddRouteState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: ScreenUtilHelper.scaleAll(20),
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "Add route",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                    Text(
                      "Select route",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(18),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: _inputDecoration("From"),
                      onChanged: (val) =>
                          context.read<AddRouteBloc>().add(FromChanged(val)),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                        child: Icon(Icons.swap_vert,
                            size: 25, color: Colors.black87,)),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: _inputDecoration("To"),
                      onChanged: (val) =>
                          context.read<AddRouteBloc>().add(ToChanged(val)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "ABC School to Rajaji nagar | 5 km | 20 min",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select stops",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(18),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(104, 32),
                            backgroundColor: const Color(0xFF0D80F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          onPressed: () {
                            context.read<AddRouteBloc>().add(
                                StopAdded("Stop ${state.stops.length + 1}"));
                          },
                          child: const Text(
                            "Add Route",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    ...state.stops.map(
                          (stop) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 53,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF5F6FA),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.black54, size: 20),
                                  SizedBox(height: 4),
                                  Text(
                                    "View\non map",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                height: 56,
                                width: 300,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xFFF5F6FA),
                                ),
                                child: Text(
                                  stop,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      "Select route name",
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(18),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: _inputDecoration("Route A1"),
                      onChanged: (val) => context
                          .read<AddRouteBloc>()
                          .add(RouteNameChanged(val)),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(104, 32),
                          backgroundColor: const Color(0xFF0D80F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          // final bloc = context.read<AddRouteBloc>();
                          // bloc.add(StopAdded("Stop ${state.stops.length + 1}"));

                          context.pushReplacement(AppRoutes.addRouteConfirm);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => BlocProvider.value(
                          //       value: bloc, // reuse same bloc
                          //       child: const AddRouteConfirmScreen(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: const Text(
                          "Add Stop",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            },
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
