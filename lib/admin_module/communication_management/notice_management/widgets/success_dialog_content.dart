
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

class SuccessDialogContent extends StatelessWidget {
  final bool isPublish;

  const SuccessDialogContent({Key? key, required this.isPublish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: ScreenUtilHelper.width(336.0),
      height: ScreenUtilHelper.height(337.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10.0)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: ScreenUtilHelper.radius(10.0),
            spreadRadius: ScreenUtilHelper.radius(1.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(24.0),
              vertical: ScreenUtilHelper.height(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(flex: 2),

                // --- FIX START: Icon ko Image.asset se replace kiya gaya hai ---
                Image.asset(
                  'assets/images/dialogbox.png', // Aapka image path
                  width: ScreenUtilHelper.width(85),
                  height: ScreenUtilHelper.height(85),
                  // Agar image load na ho to fallback ke liye
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.check_circle_outline,
                      color: AppColors.success,
                      size: ScreenUtilHelper.scaleAll(60.0),
                    );
                  },
                ),
                // --- FIX END ---

                SizedBox(height: ScreenUtilHelper.height(28.0)),
                Text(
                  isPublish ? 'Successfully Published!' : 'Successfully Saved!',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.graphite,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ScreenUtilHelper.height(12.0)),
                Text(
                  isPublish
                      ? 'Your notice has been published successfully'
                      : 'Your notice has been saved successfully',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(15.0),
                    color: AppColors.graphite,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiaryAccent,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(
                      ScreenUtilHelper.width(180),
                      ScreenUtilHelper.height(48),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.radius(6.0)),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(25),
                      vertical: ScreenUtilHelper.height(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: ()=>GoRouter.of(context).pop(),
                  child: Text(
                    'Create new',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtilHelper.height(8.0),
            right: ScreenUtilHelper.width(8.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: AppColors.ash,
                size: ScreenUtilHelper.scaleAll(24.0),
              ),
              onPressed: () {
                GoRouter.of(context).pop();
              },
              tooltip: 'Close',
              splashRadius: ScreenUtilHelper.radius(20),
            ),
          ),
        ],
      ),
    );
  }
}