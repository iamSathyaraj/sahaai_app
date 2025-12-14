// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sahaai/core/providers/location_provider.dart';
// import 'package:sahaai/features/home/presentation/pages/change_location_screen.dart';


// class LocationSelectorField extends StatelessWidget {
//   final void Function()? onSelected; // optional callback when location chosen

//   const LocationSelectorField({this.onSelected, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final prov = context.watch<LocationProvider>();
//     final address = prov.primaryLocation?.address ?? 'Set your location';

//     return ListTile(
//       title: const Text('Service Location'),
//       subtitle: Text(address),
//       trailing: IconButton(
//         icon: const Icon(Icons.edit_location),
//         onPressed: () async {
//           await Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangeLocationScreen()));
//           if (onSelected != null) onSelected!();
//         },
//       ),
//     );
//   }
// }
