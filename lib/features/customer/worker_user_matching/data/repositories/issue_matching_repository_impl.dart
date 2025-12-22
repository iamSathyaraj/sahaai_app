import 'package:sahaai/core/enums/service_request_status.dart';

import '../../domain/entities/worker_entity.dart';
// import '../../domain/entities/service_request_status.dart';
import '../../domain/repositories/issue_matching_repository.dart';
import '../datasources/issue_matching_remote_datasource.dart';
import '../datasources/issue_matching_signalr_datasource.dart';
import '../models/worker_model.dart';

class IssueMatchingRepositoryImpl implements IssueMatchingRepository {
  final IssueMatchingRemoteDataSource remote;
  final IssueMatchingSignalRDataSource signalR;

  IssueMatchingRepositoryImpl({
    required this.remote,
    required this.signalR,
  });

  @override
  Future<ServiceRequestStatus> getStatus(String issueId) {
    return remote.getStatus(issueId);
  }

  @override
  Future<List<WorkerEntity>> getCandidates(String issueId) {
    return remote.getCandidates(issueId);
  }

  @override
  Future<void> selectWorker(String issueId, String workerId) {
    return remote.selectWorker(issueId, workerId);
  }

  @override
  Stream<ServiceRequestStatus> listenStatus(String issueId) async* {
    await signalR.connect(issueId);
    // yield* signalR.statusStream(issueId).map(fromInt);
    yield* signalR
    .statusStream(issueId)
    .map((value) => ServiceRequestStatus.fromInt(value));

  }

  @override
  Stream<WorkerEntity> listenWorkerAccepted(String issueId) async* {
    await signalR.connect(issueId);
    yield* signalR.workerStream(issueId).map(
      (json) => WorkerModel.fromJson(json),
    );
  }

  @override
  Future<void> disconnect() => signalR.disconnect();
}
