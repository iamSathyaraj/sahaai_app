// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sahaai/core/providers/location_provider.dart';
// import '../../data/models/location_request_model.dart';

// class ChangeLocationScreen extends StatelessWidget {
//   const ChangeLocationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<LocationProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Change Location')),
//       body: prov.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   ListTile(
//                     title: const Text('Primary Location'),
//                     subtitle: Text(prov.primaryLocation?.address ?? 'Not set'),
//                     trailing: prov.primaryLocation != null ? const Icon(Icons.star, color: Colors.orange) : null,
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.my_location),
//                     label: const Text('Use Current GPS Location'),
//                     onPressed: () async {
//                       try {
//                         await prov.fetchCurrentAndSave(setAsPrimary: true);
//                         if (context.mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location updated')));
//                           Navigator.pop(context);
//                         }
//                       } catch (e) {
//                         if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   const Divider(),
//                   const SizedBox(height: 8),
//                   const Align(alignment: Alignment.centerLeft, child: Text('Recent Locations', style: TextStyle(fontWeight: FontWeight.bold))),
//                   const SizedBox(height: 8),
//                   Expanded(
//                     child: prov.history.isEmpty
//                         ? const Center(child: Text('No history yet'))
//                         : ListView.builder(
//                             itemCount: prov.latestHistory().length,
//                             itemBuilder: (context, i) {
//                               final loc = prov.latestHistory()[i];
//                               final isPrimary = prov.primaryLocationId == loc.id;
//                               return ListTile(
//                                 title: Text(loc.address),
//                                 subtitle: Text('${loc.latitude.toStringAsFixed(6)}, ${loc.longitude.toStringAsFixed(6)}'),
//                                 leading: isPrimary ? const Icon(Icons.star, color: Colors.orange) : const Icon(Icons.location_on),
//                                 onTap: () async {
//                                   // Choose as active and optionally set as primary
//                                   await prov.chooseFromHistory(loc.id, setAsPrimary: true);
//                                   if (context.mounted) {
//                                     Navigator.pop(context);
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }
