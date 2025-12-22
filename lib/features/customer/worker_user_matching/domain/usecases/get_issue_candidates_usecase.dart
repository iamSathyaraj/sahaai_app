import '../entities/worker_entity.dart';
import '../repositories/issue_matching_repository.dart';

class GetIssueCandidatesUseCase {
  final IssueMatchingRepository repository;

  GetIssueCandidatesUseCase(this.repository);

  Future<List<WorkerEntity>> call(String issueId) {
    return repository.getCandidates(issueId);
  }
}
