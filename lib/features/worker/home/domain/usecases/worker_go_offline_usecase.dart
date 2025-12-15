import '../repositories/worker_status_repository.dart';

class WorkerGoOfflineUseCase {
  final WorkerStatusRepository repository;
  WorkerGoOfflineUseCase(this.repository);

  Future<void> call() {
    return repository.setOffline();
  }
}
