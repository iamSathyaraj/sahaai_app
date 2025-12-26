import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';

class RejectJobUseCase {
    final JobRepository repository;

RejectJobUseCase(this.repository);
  Future<void> call(String jobId) {
  
  return
   repository.rejectJob(jobId);
  }
}