// import 'package:flutter/material.dart';
//
// import 'pages/create_po_screen.dart';
// import 'pages/indent_list_screen.dart';
// import 'pages/inventory_home_screen.dart';
// import 'pages/po_management_screen.dart';
//
// class AppRoutes {
//   static Route? onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case InventoryHomeScreen.routeName:
//         return MaterialPageRoute(builder: (_) => const InventoryHomeScreen());
//       case IndentListScreen.routeName:
//         return MaterialPageRoute(builder: (_) => const IndentListScreen());
//       case PoManagementScreen.routeName:
//         return MaterialPageRoute(builder: (_) => const PoManagementScreen());
//       case CreatePoScreen.routeName:
//         return MaterialPageRoute(builder: (_) => const CreatePoScreen());
//       default:
//         return MaterialPageRoute(
//           builder:
//               (_) => Scaffold(
//                 body: Center(
//                   child: Text('No route defined for ${settings.name}'),
//                 ),
//               ),
//         );
//     }
//   }
// }
