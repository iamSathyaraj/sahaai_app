import '../../domain/repositories/worker_status_repository.dart';
import '../datasources/worker_status_remote_datasource.dart';

class WorkerStatusRepositoryImpl implements WorkerStatusRepository {
  final WorkerStatusRemoteDataSource remote;

  WorkerStatusRepositoryImpl(this.remote);

  @override
  Future<void> setOnline() {
    return remote.setOnline();
  }

  @override
  Future<void> setOffline() {
    return remote.setOffline();
  }

  @override
  Future<bool> getCurrentStatus() async {
    
    return false;
  }
}
