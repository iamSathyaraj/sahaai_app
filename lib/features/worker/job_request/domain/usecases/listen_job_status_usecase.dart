import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

class ListenJobStateUseCase {
  final JobRepository repository;
  ListenJobStateUseCase(this.repository);
  Stream<WorkerJobState> call(String jobId) => repository.listenJobStatus(jobId);
}