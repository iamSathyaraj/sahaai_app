import 'package:sahaai/features/worker/job_request/domain/enums/worker_job_status.dart';

class JobEntity {
  final String jobId;
  final String customerName;
  final String serviceType;
  final String issueDescription;
  final List<String> imageUrls;
  final String? voiceNoteUrl;
  final String area;
  final double distanceKm;
    final DateTime expiresAt; 
  final WorkerJobStatus status;

  JobEntity({
    required this.jobId,
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
}
