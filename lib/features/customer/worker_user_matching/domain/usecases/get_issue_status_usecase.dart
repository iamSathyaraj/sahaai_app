import 'package:sahaai/core/enums/service_request_status.dart';
import '../repositories/issue_matching_repository.dart';

class GetIssueStatusUseCase {
  final IssueMatchingRepository repository;

  GetIssueStatusUseCase(this.repository);

  Future<ServiceRequestStatus> call(String issueId) {
    return repository.getStatus(issueId);
  }
}
