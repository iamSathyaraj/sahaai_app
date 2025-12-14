
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sahaai/core/providers/location_provider.dart';
// import 'package:sahaai/features/home/domain/entities/location_entity.dart';
// import 'package:sahaai/features/home/presentation/pages/issue_review_screen.dart';
// import 'package:sahaai/features/home/presentation/pages/location_picker_dialogue.dart';
// import 'package:sahaai/features/home/presentation/provider/issue_provider.dart';
// import 'package:sahaai/features/home/presentation/widgets/voice_recorder.dart';

// class ServiceIssueScreen extends StatefulWidget {
//   final int serviceId;  
//   const ServiceIssueScreen({Key? key, required this.serviceId }) : super(key: key);

//   @override
//   _ServiceIssueScreenState createState() => _ServiceIssueScreenState();
// }

// class _ServiceIssueScreenState extends State<ServiceIssueScreen> {
//   final _descriptionController = TextEditingController();
//   LocationEntity? _selectedLocation;
//   List<XFile> _selectedImages = [];
//   String? _voicePath;
//   Duration _voiceDuration = Duration.zero;
//   final ImagePicker _picker = ImagePicker();

//     @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final locationProvider = Provider.of<LocationProvider>(context, listen: false);
//     _selectedLocation = locationProvider.primaryLocation;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Report Issue'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Consumer<IssueProvider>(
//         builder: (context, issueProvider, child) {
//            final isValid = _selectedLocation != null && 
//                           _descriptionController.text.trim().isNotEmpty;
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                   Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.blue[200]!),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.build, color: Colors.blue[700], size: 28),
//                     const SizedBox(width: 12),
//                     Text(
//                       "widget.serviceType.toUpperCase()",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[700],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               //  LOCATION
//               _locationSection(),
//               const SizedBox(height: 16),
              
//               //  DESCRIPTION
//               TextField(
//                 controller: _descriptionController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   labelText: 'Description *',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
//                   prefixIcon: Icon(Icons.description),
//                 ),
//               ),
//               const SizedBox(height: 24),
              
//               //  IMAGES
//               _imageSection(),
//               const SizedBox(height: 24),
            
//                      VoiceRecorder(
//                 onRecordingComplete: (path, duration) {
//                   setState(() {
//                     _voicePath = path;
//                     _voiceDuration = duration;
//                   });
//                 },
//                 initialPath: _voicePath,
//               ),
//               if (_voicePath != null) ...[
//                 const SizedBox(height: 8),
//                 Text('${_voiceDuration.inSeconds}s recorded', 
//                      style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.w500)),
//               ],
//               Consumer2<IssueProvider, LocationProvider>(
//                 builder: (context, issueProvider, locationProvider, child) {
//                   final isValid = _selectedLocation != null &&
//                       // _titleController.text.trim().isNotEmpty &&
//                       _descriptionController.text.trim().isNotEmpty;
//                            return SizedBox(
//   width: double.infinity,
//   height: 52,
//   child: ElevatedButton(
//     onPressed: !isValid ? null : _navigateToReview,
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.blue,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//     child: const Text(
//       'NEXT',
//       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     ),
//   ),
// );

                          
                  
//                   // return SizedBox(
//                   //   width: double.infinity,
//                   //   height: 52,
//                   //   child: ElevatedButton(
//                   //     onPressed: issueProvider.isSubmitting || !isValid
//                   //         ? null
//                   //         : () => _submitIssue(issueProvider),
//                   //     style: ElevatedButton.styleFrom(
//                   //       backgroundColor: Colors.blue,
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(12),
//                   //       ),
//                   //     ),
//                   //     child: issueProvider.isSubmitting
//                   //         ? const SizedBox(
//                   //             width: 20,
//                   //             height: 20,
//                   //             child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
//                   //           )
//                   //         : const Text(
//                   //             'Submit Issue',
//                   //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   //           ),
//                   //   ),
//                   // );
//                 },
//               ),
              
//               const SizedBox(height: 16),
              
//               Consumer<IssueProvider>(
//                 builder: (context, issueProvider, child) {
//                   if (issueProvider.error != null) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         issueProvider.error!,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }
//                   if (issueProvider.successMessage != null) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         issueProvider.successMessage!,
//                         style: const TextStyle(color: Colors.green),
//                       ),
//                     );
//                   }
//                   return const SizedBox();
//                 },
//               ),
//             ],
//           )
          
//         );
//         }
//       ),
//     ); 
//   }

//   Widget _locationSection() {
//     return Consumer<LocationProvider>(
//       builder: (context, provider, child) {
//         _selectedLocation ??= provider.primaryLocation;
//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: Row(
//             children: [
//               const Icon(Icons.location_on, color: Colors.blue, size: 28),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _selectedLocation?.address ?? 'Set location first',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: _selectedLocation != null ? Colors.black87 : Colors.grey,
//                       ),
//                     ),
//                     TextButton.icon(
//                       onPressed: () => _showLocationPicker(context, provider),
//                       icon: const Icon(Icons.edit_location_alt, size: 18),
//                       label: Text(_selectedLocation == null ? 'Set Location' : 'Change Location'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _imageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Photos (Optional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 12),
//         GestureDetector(
//           onTap: _pickImages,
//           child: Container(
//             height: 100,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[400]!),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: _selectedImages.isEmpty
//                 ? const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey),
//                         Text('Tap to add photos', style: TextStyle(color: Colors.grey)),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _selectedImages.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index == _selectedImages.length) {
//                         return GestureDetector(
//                           onTap: _pickImages,
//                           child: Container(
//                             width: 80,
//                             margin: const EdgeInsets.all(4),
//                             child: const Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.add_photo_alternate, size: 30),
//                                 Text('Add', style: TextStyle(fontSize: 12)),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                       return Container(
//                         margin: const EdgeInsets.all(4),
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.file(
//                                 File(_selectedImages[index].path),
//                                 width: 80,
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: GestureDetector(
//                                 onTap: () => setState(() => _selectedImages.removeAt(index)),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: const BoxDecoration(
//                                     color: Colors.red,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(Icons.close, color: Colors.white, size: 16),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ),
//         if (_selectedImages.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.only(top: 8),
//             child: Text('${_selectedImages.length} photo(s) selected', style: TextStyle(color: Colors.green[600])),
//           ),
//       ],
//     );
//   }
//   Future<void> _pickImages() async {
//     try {
//       final pickedFiles = await _picker.pickMultiImage();
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         setState(() {
//           _selectedImages.addAll(pickedFiles);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to pick images: $e')),
//       );
//     }
//   }
//   void _showLocationPicker(BuildContext context, LocationProvider provider) {
//     provider.loadLocationHistory(); 
//     showDialog(
//       context: context,
//       builder: (context) => LocationPickerDialog(
//         onLocationSelected: (location) {
//           if (location != null) {
//             setState(() {
//               _selectedLocation = location;
//             });
//           }
//         },
//       ),
//     );
//   }

//   void _navigateToReview() {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => IssueReviewScreen(
//         serviceId: widget.serviceId,
//         // serviceName: _serviceName, 
//         description: _descriptionController.text.trim(),
//         location: _selectedLocation!,
//         images: _selectedImages,
//         voicePath: _voicePath,
//         voiceDuration: _voiceDuration,
//       ),
//     ),
//   );
// }


//   // Future<void> _submitIssue(IssueProvider issueProvider) async {
//   //   final images = _selectedImages.map((xfile) => File(xfile.path)).where((file) => file.existsSync()).toList();
    
//   //   final success = await issueProvider.submitIssue(
//   //     // title: _titleController.text.trim(),
//   //     description: _descriptionController.text.trim(),
//   //     locationId: _selectedLocation!.id,
//   //    serviceId: widget.serviceId, 
//   //     images: images,
//   //     voicePath: _voicePath,
//   //   );

//   //   if (success) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Issue created successfully!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //     Navigator.pop(context);
//   //   }
//   // }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahaai/core/providers/location_provider.dart';
import 'package:sahaai/features/home/domain/entities/location_entity.dart';
import 'package:sahaai/features/home/presentation/pages/issue_review_screen.dart';
import 'package:sahaai/features/home/presentation/pages/location_picker_dialogue.dart';
import 'package:sahaai/features/home/presentation/provider/issue_provider.dart';
import 'package:sahaai/features/home/presentation/widgets/voice_recorder.dart';

class ServiceIssueScreen extends StatefulWidget {
  final int serviceId;
  final String serviceName; // <-- pass from home screen

  const ServiceIssueScreen({
    Key? key,
    required this.serviceId,
    required this.serviceName,
  }) : super(key: key);

  @override
  _ServiceIssueScreenState createState() => _ServiceIssueScreenState();
}

class _ServiceIssueScreenState extends State<ServiceIssueScreen> {
  final _descriptionController = TextEditingController();
  LocationEntity? _selectedLocation;
  List<XFile> _selectedImages = [];
  String? _voicePath;
  Duration _voiceDuration = Duration.zero;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    _selectedLocation = locationProvider.primaryLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<IssueProvider>(
        builder: (context, issueProvider, child) {
          final isValid = _selectedLocation != null &&
              _descriptionController.text.trim().isNotEmpty;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SERVICE HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.build, color: Colors.blue[700], size: 28),
                      const SizedBox(width: 12),
                      Text(
                        widget.serviceName.toUpperCase(), // from backend
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // LOCATION
                _locationSection(),
                const SizedBox(height: 16),

                // DESCRIPTION
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 24),

                // IMAGES
                _imageSection(),
                const SizedBox(height: 24),

                // VOICE
                VoiceRecorder(
                  onRecordingComplete: (path, duration) {
                    setState(() {
                      _voicePath = path;
                      _voiceDuration = duration;
                    });
                  },
                  initialPath: _voicePath,
                ),
                if (_voicePath != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${_voiceDuration.inSeconds}s recorded',
                    style: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // NEXT BUTTON → REVIEW SCREEN
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: !isValid ? null : _navigateToReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Optional error/success from provider (can remove if unused)
                Consumer<IssueProvider>(
                  builder: (context, issueProvider, child) {
                    if (issueProvider.error != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          issueProvider.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (issueProvider.successMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          issueProvider.successMessage!,
                          style: const TextStyle(color: Colors.green),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _locationSection() {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        _selectedLocation ??= provider.primaryLocation;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedLocation?.address ?? 'Set location first',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _selectedLocation != null
                            ? Colors.black87
                            : Colors.grey,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showLocationPicker(context, provider),
                      icon:
                          const Icon(Icons.edit_location_alt, size: 18),
                      label: Text(
                        _selectedLocation == null
                            ? 'Set Location'
                            : 'Change Location',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _imageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos (Optional)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _selectedImages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate,
                            size: 40, color: Colors.grey),
                        Text('Tap to add photos',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _selectedImages.length) {
                        return GestureDetector(
                          onTap: _pickImages,
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.all(4),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 30),
                                Text('Add', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.all(4),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => _selectedImages.removeAt(index),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
        if (_selectedImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${_selectedImages.length} photo(s) selected',
              style: TextStyle(color: Colors.green[600]),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  void _showLocationPicker(BuildContext context, LocationProvider provider) {
    provider.loadLocationHistory();
    showDialog(
      context: context,
      builder: (context) => LocationPickerDialog(
        onLocationSelected: (location) {
          if (location != null) {
            setState(() {
              _selectedLocation = location;
            });
          }
        },
      ),
    );
  }

  void _navigateToReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IssueReviewScreen(
          serviceId: widget.serviceId,
          serviceName: widget.serviceName,
          description: _descriptionController.text.trim(),
          location: _selectedLocation!,
          images: _selectedImages,
          voicePath: _voicePath,
          voiceDuration: _voiceDuration,
        ),
      ),
    );
  }
}
