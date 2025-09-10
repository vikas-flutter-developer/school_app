import 'package:edudibon_flutter_bloc/widgets/app_bar_tab.dart' show AppBarTab;
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int? _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: SizedBox(
        width: 375,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.deepPurple[100],
          ),
          child: Row(
            children: [
              Expanded(
                child: AppBarTab(
                  title: 'Class Time-table',
                  index: 0,
                  selectedIndex: _selectedIndex,
                  onTabSelected: _onTabSelected,
                ),
              ),
              Container(
                height: 24,
                width: 1,
                color: Colors.deepPurple[700],
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Expanded(
                child: AppBarTab(
                  title: 'Exam and Events',
                  index: 1,
                  selectedIndex: _selectedIndex,
                  onTabSelected: _onTabSelected,
                ),
              ),
            ],
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}
