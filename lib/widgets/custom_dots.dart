import 'package:flutter/material.dart';

class PaginationDots extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onDotTap;
  final double dotSize;
  final double dotSpacing;
  final Color activeColor;
  final Color inactiveColor;

  const PaginationDots({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onDotTap,
    this.dotSize = 10.0,
    this.dotSpacing = 16.0,
    this.activeColor = Colors.black, // Active color is black
    this.inactiveColor = Colors.transparent, // Inactive color is transparent
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(totalPages, (index) {
        return GestureDetector(
          onTap: () => onDotTap(index),
          child: Container(
            width: dotSize,
            height: dotSize,
            margin: EdgeInsets.symmetric(horizontal: dotSpacing / 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentPage ? activeColor : inactiveColor,
              border: Border.all(
                color: index == currentPage ? activeColor : Colors.grey,
                width: 1.0,
              ),
            ),
          ),
        );
      }),
    );
  }
}