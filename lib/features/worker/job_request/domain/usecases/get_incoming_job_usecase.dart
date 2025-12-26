import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';
import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';

class GetIncomingJobUseCase {
  final JobRepository repository;

  GetIncomingJobUseCase(this.repository);

  Stream<JobEntity?> call() {
    return repository.listenIncomingJob();
  }
}
