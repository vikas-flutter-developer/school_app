import 'package:flutter/material.dart';

class TimetableTab extends StatelessWidget {
  final String tabName;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final Animation<double> animation;

  const TimetableTab({
    super.key,
    required this.tabName,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? 1.1 - (animation.value * 0.1) : 1.0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 0.7,
                    color: Color.fromRGBO(184, 184, 184, 1),
                  ),
                  color:
                      isSelected
                          ? Color.fromRGBO(74, 68, 182, 1)
                          : Colors.transparent,
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    tabName,
                    style: TextStyle(
                      //color: Colors.black,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
