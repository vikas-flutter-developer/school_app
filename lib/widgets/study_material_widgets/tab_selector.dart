import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class TabSelector extends StatefulWidget {
  const TabSelector({super.key});

  @override
  _TabSelectorState createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16), // Added padding on left & right
      child: Container(
        color: AppColors.primaryLight, // Light blue background for the whole tab
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = 0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "Solved question paper",
                    style: TextStyle(
                      color: selectedIndex == 0 ? Colors.black : Colors.white, // Selected = Black, Unselected = White
                      fontWeight: FontWeight.bold, fontSize: 12
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 2, // Dark blue separator line
              height: 30,
              color: Colors.blue[900],
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = 1),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "Previous year question paper",
                    style: TextStyle(
                      color: selectedIndex == 1 ? Colors.black : Colors.white, // Selected = Black, Unselected = White
                      fontWeight: FontWeight.bold,fontSize: 12
                    ),
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
