// import 'package:flutter/material.dart';
//
// class BookAddedOverlay extends StatelessWidget {
//   const BookAddedOverlay({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         height: 35,
//         width: 130,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.deepPurple, width: 1.5),
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(3),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.deepPurple, width: 2),
//                 color: Colors.white,
//               ),
//               child: const Icon(
//                 Icons.check,
//                 size: 16,
//                 color: Colors.deepPurple,
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Book Added',
//               style: TextStyle(
//                 color: Colors.deepPurple,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
