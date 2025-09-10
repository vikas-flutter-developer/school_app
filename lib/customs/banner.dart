import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String imagePath;

  const BannerWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 4,
        //   )
        // ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        imagePath,
        fit: BoxFit.fitWidth, // or BoxFit.none for no scaling
      ),
    );
  }
}
