import 'package:dio/dio.dart';
import 'package:sahaai/core/enums/service_request_status.dart';
// import '../../domain/entities/service_request_status.dart';
import '../models/worker_model.dart';

class IssueMatchingRemoteDataSource {
  final Dio dio;

  IssueMatchingRemoteDataSource(this.dio);

  Future<ServiceRequestStatus> getStatus(String issueId) async {
    try {
      final res = await dio.get('/issues/$issueId');
      final statusInt = res.data['status'] as int;
      // return fromInt(statusInt);
      return ServiceRequestStatus.fromInt(statusInt);

    } on DioException catch (e) {
      final message = _extractMessage(e, 'Failed to load issue status');
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to load issue status: $e');
    }
  }

  Future<List<WorkerModel>> getCandidates(String issueId) async {
    try {
      final res = await dio.get('/issues/$issueId/candidates');
      final list = res.data as List<dynamic>;
      return list
          .map((e) => WorkerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final message = _extractMessage(e, 'Failed to load candidates');
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to load candidates: $e');
    }
  }

  Future<void> selectWorker(String issueId, String workerId) async {
    try {
      await dio.post(
        '/issues/$issueId/select-worker',
        data: {'workerId': workerId},
      );
    } on DioException catch (e) {
      final message = _extractMessage(e, 'Failed to select worker');
      throw Exception(message);
    } catch (e) {
      throw Exception('Failed to select worker: $e');
    }
  }

  String _extractMessage(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'] as String;
    }
    return fallback;
  }
}

