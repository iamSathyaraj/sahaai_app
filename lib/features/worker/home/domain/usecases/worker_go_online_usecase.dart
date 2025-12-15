import '../repositories/worker_status_repository.dart';

class WorkerGoOnlineUseCase {
  final WorkerStatusRepository repository;
  WorkerGoOnlineUseCase(this.repository);

  Future<void> call() {
    return repository.setOnline();
  }
}
