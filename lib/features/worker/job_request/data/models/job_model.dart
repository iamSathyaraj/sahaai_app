

import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';

import '../../domain/enums/worker_job_status.dart';

class JobModel {
  final String id;
  final String customerName;
  final String serviceType;
  final String issueDescription;
  final List<String> imageUrls;
  final String? voiceNoteUrl;
  final String area;
    final DateTime expiresAt; 

  final double distanceKm;
  final WorkerJobStatus status;

  JobModel({
    required this.id,
    required this.customerName,
    required this.serviceType,
    required this.issueDescription,
    required this.imageUrls,
    this.voiceNoteUrl,
    required this.area,
    required this.distanceKm,
    required this.expiresAt,
    required this.status,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      customerName: json['customer_name'] as String,
      serviceType: json['service_type'] as String,
      issueDescription: json['issue_description'] as String,
      imageUrls: List<String>.from(json['images'] ?? []),
      voiceNoteUrl: json['voice_note'],
      area: json['area'] as String,
      distanceKm: (json['distance_km'] as num).toDouble(),
      expiresAt: DateTime.now().add(Duration(seconds: json['expires_in_seconds'] ?? 15)),
      status: WorkerJobStatus.values.byName(
        json['status'] as String,
      ),
    );
  }

  JobEntity toEntity() {
    return JobEntity(
      jobId: id,
      customerName: customerName,
      serviceType: serviceType,
      issueDescription: issueDescription,
      imageUrls: imageUrls,
      voiceNoteUrl: voiceNoteUrl,
      area: area,
      distanceKm: distanceKm,
      expiresAt: expiresAt,
      status: status,
    );
  }
}
