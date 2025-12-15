import 'package:sahaai/core/network/dio_client.dart';
import 'worker_status_remote_datasource.dart';

class WorkerStatusRemoteDataSourceImpl implements WorkerStatusRemoteDataSource {
  final DioClient dioClient;

  WorkerStatusRemoteDataSourceImpl(this.dioClient);

  @override
  Future<void> setOnline() async {
    await dioClient.dio.post('/worker/status', data: {'isOnline': true});
  }

  @override
  Future<void> setOffline() async {
    await dioClient.dio.post('/worker/status', data: {'isOnline': false});
  }
}
