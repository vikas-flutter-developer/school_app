import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final BoxFit fitImage;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    this.fitImage = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtilHelper.width(50), // smaller width
        height: ScreenUtilHelper.width(50), // smaller height
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.3),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main content column (icon + title)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    imagePath,
                    width: 30,
                    height: 30,
                    fit: fitImage,
                  ),
                  const SizedBox(height: 6), // smaller gap
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(12),
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom right arrow
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/arrow.png',
                width: ScreenUtilHelper.width(32), // big arrow
                height: ScreenUtilHelper.width(32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
