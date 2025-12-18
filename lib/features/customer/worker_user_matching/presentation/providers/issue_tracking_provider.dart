
import 'package:flutter/material.dart';
import '../models/worker_ui_model.dart';

enum ServiceRequestStatus {
  pending,
  searching,
  expandingRadius,
  accepted,
  inProgress,
  completed,
  cancelled,
  noWorkersAvailable,
}

class IssueTrackingProvider extends ChangeNotifier {
  ServiceRequestStatus status = ServiceRequestStatus.searching;
  final List<WorkerUiModel> workers = [];
  String? errorMessage;
  bool isSelecting = false;
  bool isLoading = false;

  bool get isSearching =>
      status == ServiceRequestStatus.searching ||
      status == ServiceRequestStatus.expandingRadius;

  bool get hasWorkers => workers.isNotEmpty;

  void simulateWorkerComing() {
    workers.add(
      WorkerUiModel(
        id: "id",
        name: 'Test Worker',
        rating: 4.5,
        distanceKm: 2.3,
      ),
    );
    status = ServiceRequestStatus.accepted;
    notifyListeners();
  }

  void simulateNoWorkers() {
    status = ServiceRequestStatus.noWorkersAvailable;
    notifyListeners();
  }

  void simulateExpandRadius() {
    status = ServiceRequestStatus.expandingRadius;
    notifyListeners();
  }
}
