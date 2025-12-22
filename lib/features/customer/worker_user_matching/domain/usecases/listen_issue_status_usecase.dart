import 'package:sahaai/core/enums/service_request_status.dart';
import '../repositories/issue_matching_repository.dart';

class ListenIssueStatusUseCase {
  final IssueMatchingRepository repository;

  ListenIssueStatusUseCase(this.repository);

  Stream<ServiceRequestStatus> call(String issueId) {
    return repository.listenStatus(issueId);
  }

  Future<void> stop() {
    return repository.disconnect();
  }
}
