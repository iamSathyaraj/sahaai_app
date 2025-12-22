import '../entities/worker_entity.dart';
import '../repositories/issue_matching_repository.dart';

class ListenWorkerAcceptedUseCase {
  final IssueMatchingRepository repository;

  ListenWorkerAcceptedUseCase(this.repository);

  Stream<WorkerEntity> call(String issueId) {
    return repository.listenWorkerAccepted(issueId);
  }
}
