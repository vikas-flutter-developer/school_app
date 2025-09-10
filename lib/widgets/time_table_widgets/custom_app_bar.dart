import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../student_module/attendance&timetable&report/bloc/app_tab/app_tab_bloc.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          final router = GoRouter.of(context);
          if (router.canPop()) {
            router.pop();
          } else {
            router.go('/student'); // or your dashboard route
          }
        },
      ),
      title: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        color: Colors.deepPurple[100],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBarTab(context, 'Class Time-table', 0),
            Container(
              height: 24,
              width: 1,
              color: Colors.deepPurple[700],
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            _buildAppBarTab(context, 'Exam and Events', 1),
          ],
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildAppBarTab(BuildContext context, String title, int index) {
    return BlocBuilder<AppTabBloc, AppTabState>(
      builder: (context, state) {
        final isSelected = state.mainTabIndex == index;  // <-- Use mainTabIndex here
        return Expanded(
          child: GestureDetector(
            onTap: () => context.read<AppTabBloc>().add(MainTabChanged(index)), // <-- Use MainTabChanged event
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
