import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';

class AcceptJobUseCase {
  final JobRepository repository;

  AcceptJobUseCase(this.repository);

  Future<void> call(String jobId) {
    return repository.acceptJob(jobId);
  }
}
