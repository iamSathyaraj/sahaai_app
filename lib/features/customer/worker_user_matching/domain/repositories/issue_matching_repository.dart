import 'package:sahaai/core/enums/service_request_status.dart';
import '../entities/worker_entity.dart';

abstract class IssueMatchingRepository {
  // REST
  Future<ServiceRequestStatus> getStatus(String issueId);
  Future<List<WorkerEntity>> getCandidates(String issueId);
  Future<void> selectWorker(String issueId, String workerId);

  // SignalR
  Stream<ServiceRequestStatus> listenStatus(String issueId);
  Stream<WorkerEntity> listenWorkerAccepted(String issueId);

  Future<void> disconnect();
}
