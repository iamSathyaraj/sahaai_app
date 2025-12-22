import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sahaai/core/enums/service_request_status.dart';
import 'package:sahaai/features/customer/worker_user_matching/presentation/models/worker_ui_model.dart';
import '../../domain/entities/worker_entity.dart';
import '../../domain/usecases/get_issue_status_usecase.dart';
import '../../domain/usecases/get_issue_candidates_usecase.dart';
import '../../domain/usecases/select_worker_usecase.dart';
import '../../domain/usecases/listen_issue_status_usecase.dart';
import '../../domain/usecases/listen_worker_accepted_usecase.dart';

class IssueTrackingProvider extends ChangeNotifier {
  final GetIssueStatusUseCase getIssueStatusUseCase;
  final GetIssueCandidatesUseCase getIssueCandidatesUseCase;
  final SelectWorkerUseCase selectWorkerUseCase;
  final ListenIssueStatusUseCase listenIssueStatusUseCase;
  final ListenWorkerAcceptedUseCase listenWorkerAcceptedUseCase;

  IssueTrackingProvider({
    required this.getIssueStatusUseCase,
    required this.getIssueCandidatesUseCase,
    required this.selectWorkerUseCase,
    required this.listenIssueStatusUseCase,
    required this.listenWorkerAcceptedUseCase,
  });

  ServiceRequestStatus status = ServiceRequestStatus.pending;
  final List<WorkerUiModel> workers = [];

  bool isLoading = false;
  bool isSelecting = false;
  String? errorMessage;

  StreamSubscription<ServiceRequestStatus>? _statusSub;
  StreamSubscription<WorkerEntity>? _workerSub;

  bool get isSearching =>
      status == ServiceRequestStatus.searching ||
      status == ServiceRequestStatus.expandingRadius;

  bool get hasWorkers => workers.isNotEmpty;

  // Call this once from IssueSearchingScreen / IssueFlowScreen
  Future<void> init(String issueId) async {
    if (isLoading || _statusSub != null || _workerSub != null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 1) Initial REST snapshot
      final currentStatus = await getIssueStatusUseCase(issueId);
      status = currentStatus;

      final candidates = await getIssueCandidatesUseCase(issueId);
      workers
        ..clear()
        ..addAll(
          candidates.map(
            (w) => WorkerUiModel(
              id: w.id,
              name: w.name,
              rating: w.rating,
              distanceKm: w.distanceKm,
            ),
          ),
        );

      // 2) Start SignalR listeners
      _statusSub = listenIssueStatusUseCase(issueId).listen(
        (newStatus) {
          status = newStatus;
          notifyListeners();
        },
        onError: (e) {
          errorMessage = e.toString();
          notifyListeners();
        },
      );

      _workerSub = listenWorkerAcceptedUseCase(issueId).listen(
        (worker) {
          workers.add(
            WorkerUiModel(
              id: worker.id,
              name: worker.name,
              rating: worker.rating,
              distanceKm: worker.distanceKm,
            ),
          );
          // if (status == ServiceRequestStatus.searching ||
          //     status == ServiceRequestStatus.expandingRadius) {
          //   status = ServiceRequestStatus.accepted;
          // }
          // notifyListeners();
        },
        onError: (e) {
          errorMessage = e.toString();
          notifyListeners();
        },
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCandidates(String issueId) async {
    try {
      final candidates = await getIssueCandidatesUseCase(issueId);
      workers
        ..clear()
        ..addAll(
          candidates.map(
            (w) => WorkerUiModel(
              id: w.id,
              name: w.name,
              rating: w.rating,
              distanceKm: w.distanceKm,
            ),
          ),
        );
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> selectWorker(String issueId, String workerId) async {
    isSelecting = true;
    errorMessage = null;
    notifyListeners();

    try {
      await selectWorkerUseCase(issueId, workerId);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isSelecting = false;
      notifyListeners();
    }
  }

  Future<void> disposeStreams() async {
    await _statusSub?.cancel();
    await _workerSub?.cancel();
    _statusSub = null;
    _workerSub = null;
    await listenIssueStatusUseCase.stop();
  }

  @override
  void dispose() {
    disposeStreams();
    super.dispose();
  }
}
