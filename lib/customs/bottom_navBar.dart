import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersistentNavWrapper extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  final int role;

  const PersistentNavWrapper({
    super.key,
    required this.child,
    required this.state,
    required this.role,
  });

  @override
  State<PersistentNavWrapper> createState() => _PersistentNavWrapperState();
}

class _PersistentNavWrapperState extends State<PersistentNavWrapper> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    print(location);
    if (location.endsWith(AppRoutes.adminDashboard) ||
        location.endsWith(AppRoutes.teacherDashboard) ||
        location.endsWith(AppRoutes.studentDashboard)) {
      return 0;
    }
    if (location.endsWith(AppRoutes.adminFeed) ||
        location.endsWith(AppRoutes.studentFeed) ||
        location.endsWith(AppRoutes.teacherFeed)) {
      return 1;
    }
    if (location.endsWith(AppRoutes.adminProfile) ||
        location.endsWith(AppRoutes.teacherProfile) ||
        location.endsWith(AppRoutes.studentProfile)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context, int role) {
    switch (index) {
      case 0:
        if (role == 0) context.go(AppRoutes.adminDashboard);
        if (role == 1) context.go(AppRoutes.teacherDashboard);
        if (role == 2) context.go(AppRoutes.studentDashboard);
        break;
      case 1:
        if (role == 0) context.go(AppRoutes.adminFeed);
        if (role == 1) context.go(AppRoutes.studentFeed);
        if (role == 2) context.go(AppRoutes.teacherFeed);
        break;
      case 2:
        if (role == 0) context.go(AppRoutes.adminProfile);
        if (role == 1) context.go(AppRoutes.studentProfile);
        if (role == 2) context.go(AppRoutes.teacherProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _calculateSelectedIndex(context),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.white,
        onTap: (index) => _onItemTapped(index, context, widget.role),
      ),
    );
  }
}
