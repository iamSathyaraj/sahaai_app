// // features/home/presentation/screens/issue_confirmation_screen.dart
// import 'package:flutter/material.dart';

// class IssueConfirmationScreen extends StatelessWidget {
//   const IssueConfirmationScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.check_circle, size: 120, color: Colors.green),
//               const SizedBox(height: 32),
//               const Text(
//                 'ISSUE CREATED SUCCESSFULLY!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Your service request has been submitted.\nA professional will contact you soon.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 48),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () =>
//                       //  Navigator.popUntil((route) => route.isFirst),
//                       Navigator.pop(context),
//                       icon: const Icon(Icons.home),
//                       label: const Text('HOME'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.list),
//                       label: const Text('MY ISSUES'),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
