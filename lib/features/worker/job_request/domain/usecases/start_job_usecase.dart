import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';


class StartJobUseCase {
  final JobRepository repository;

  StartJobUseCase(this.repository);

  Future<bool> call(String jobId) async {
    return await repository.startJob(jobId);
  }
}
