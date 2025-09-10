import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';




class AddRouteConfirmScreen extends StatefulWidget {
  const AddRouteConfirmScreen({super.key});

  @override
  State<AddRouteConfirmScreen> createState() => _AddRouteConfirmScreenState();
}

class _AddRouteConfirmScreenState extends State<AddRouteConfirmScreen> {
  final List<Map<String, String>> stops = [
    {"stop": "Stop 1", "address": "123 Main St"},
    {"stop": "Stop 2", "address": "456 Oak Ave"},
    {"stop": "Stop 3", "address": "789 Pine Ln"},
  ];

  Widget _stopCard(String stop, String address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stop,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputBox(String placeholder) {
    return Container(
      height: 56,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        placeholder,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _CustomLogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Back arrow + title
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: ScreenUtilHelper.scaleAll(20),
                      color: Colors.black,
                    ),
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

            const SizedBox(height: 24),

            /// Selected stops section
            const Text(
              "Selected stops",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...stops.map((s) => _stopCard(s['stop']!, s['address']!)),

            const SizedBox(height: 30),

            /// Select route section
            const Text(
              "Select route",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _inputBox("Estimated Distance (miles)"),
            _inputBox("Estimated Travel Time (minutes)"),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D80F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  showSuccessDialog(context);
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
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
                Icon(
                  Icons.notifications_outlined,
                  color: AppColors.black,
                  size: ScreenUtilHelper.scaleAll(32),
                ),
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


void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Disable closing on tap outside
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color(0xFFDEE5FB), // Light border
            width: 1.2,
          ),
        ),
        child: SizedBox(
          width: 336,
          height: 269,
          child: Stack(
            children: [
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close_sharp,
                    size: 25,
                    color: Colors.black45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Green Badge with Checkmark
                      Image.asset(
                        'assets/images/route_success_badge.png',
                        width: 85.27,
                        height: 85.27,
                      ),
                      const SizedBox(height: 20),

                      // Title
                      const Text(
                        "Successfully Added Route!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        "Your notice has been published successfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
