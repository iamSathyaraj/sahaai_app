 // features/home/presentation/screens/issue_review_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/home/presentation/pages/issue_confirm_screen.dart';
import 'package:sahaai/features/home/presentation/provider/issue_provider.dart';
import 'package:sahaai/features/home/domain/entities/location_entity.dart';
// import 'issue_confirmation_screen.dart'; // Create this next

class IssueReviewScreen extends StatelessWidget {
  final int serviceId;
  final String serviceName;
  final String description;
  final LocationEntity location;
  final List<XFile> images;
  final String? voicePath;
  final Duration voiceDuration;

  const IssueReviewScreen({
    Key? key,
    required this.serviceId,
    required this.serviceName,  
    required this.description,
    required this.location,
    required this.images,
    this.voicePath,
    required this.voiceDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$serviceName REVIEW'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SERVICE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
                    serviceName.toUpperCase(),
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
            _buildInfoCard('📍 LOCATION', location.address),

            // DESCRIPTION
            _buildInfoCard('📝 DESCRIPTION', description),

            // IMAGES
            if (images.isNotEmpty) ...[
              _buildInfoCard('📸 PHOTOS (${images.length})', 'Tap to view'),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(images[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            // VOICE
            if (voicePath != null) 
              _buildInfoCard('🎤 VOICE NOTE', '${voiceDuration.inSeconds}s - ${voicePath!.split('/').last}'),

            const SizedBox(height: 32),

            // SUBMIT BUTTON
            Consumer<IssueProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: provider.isSubmitting ? null : () => _submitIssue(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: provider.isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                          )
                        : const Text(
                            'SUBMIT ISSUE',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _submitIssue(BuildContext context) {
    final provider = Provider.of<IssueProvider>(context, listen: false);
    final title = 'Service Request - $serviceName';
    
    provider.submitIssue(
      // title: title,
      description: description,
      locationId: location.id,
      serviceId: serviceId,
      images: images.map((xfile) => File(xfile.path)).where((file) => file.existsSync()).toList(),
      voicePath: voicePath,
    ).then((success) {
      if (success && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const IssueConfirmationScreen()),
        );
      }
    });
  }
}
