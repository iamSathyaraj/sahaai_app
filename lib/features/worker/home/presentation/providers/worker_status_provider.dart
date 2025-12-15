import 'package:flutter/material.dart';
import '../../domain/usecases/worker_go_online_usecase.dart';
import '../../domain/usecases/worker_go_offline_usecase.dart';

class WorkerStatusProvider extends ChangeNotifier {
  final WorkerGoOnlineUseCase goOnlineUseCase;
  final WorkerGoOfflineUseCase goOfflineUseCase;

  WorkerStatusProvider({
    required this.goOnlineUseCase,
    required this.goOfflineUseCase,
  });

  bool isOnline = false;
  bool isLoading = false;
  String? errorMessage;

  void setLocalStatus(bool value) {
    isOnline = value;
    notifyListeners();
  }

  void setInitialStatus(bool value) {
    isOnline = value;
    notifyListeners();
  }

  Future<void> goOnline() async {
    if (isLoading || isOnline) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await goOnlineUseCase();
      isOnline = true;
    } catch (e) {
      errorMessage = 'Failed to go online. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> goOffline() async {
    if (isLoading || !isOnline) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await goOfflineUseCase();
      isOnline = false;
    } catch (e) {
      errorMessage = 'Failed to go offline. Please try again.';
    } finally {
      isLoading = false; 
      notifyListeners();
    }
  }
}
