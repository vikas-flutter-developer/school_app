import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_routes.dart';

class PersistentNavWrapper extends StatelessWidget {
  final Widget child;
  final GoRouterState state;

  const PersistentNavWrapper({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // Current active page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(state.uri.toString()),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.adminDashboard);
              break;
            case 1:
              context.go(AppRoutes.adminFeed);
              break;
            case 2:
              context.go(AppRoutes.adminProfile);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith(AppRoutes.adminFeed)) return 1;
    if (location.startsWith(AppRoutes.adminProfile)) return 2;
    return 0;
  }
}
