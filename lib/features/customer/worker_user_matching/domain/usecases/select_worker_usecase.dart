import '../repositories/issue_matching_repository.dart';

class SelectWorkerUseCase {
  final IssueMatchingRepository repository;

  SelectWorkerUseCase(this.repository);

  Future<void> call(String issueId, String workerId) {
    return repository.selectWorker(issueId, workerId);
  }
}
