import 'dart:developer';

import 'package:dio/dio.dart';
import 'job_remote_data_source.dart';

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final Dio dio;

  JobRemoteDataSourceImpl({required this.dio});

  @override
  Future<bool> acceptJob(String jobId) async {
    try {
      log(' Accepting job: $jobId');
      final response = await dio.post('/api/worker/jobs/$jobId/accept');
      log(' Accept job $jobId: ${response.statusCode}');
      return _isSuccess(response.statusCode);
    } on DioException catch (e) {
      _logDioError('accept', jobId, e);
      return false;
    } catch (e) {
      log(' Accept job $jobId unexpected error: $e');
      return false;
    }
  }

  @override
  Future<bool> rejectJob(String jobId) async {
    try {
      log(' Rejecting job: $jobId');
      final response = await dio.post(
        '/api/worker/jobs/$jobId/reject',
        data: {'reason': 'Not available'},
      );
      log(' Reject job $jobId: ${response.statusCode}');
      return _isSuccess(response.statusCode);
    } on DioException catch (e) {
      _logDioError('reject', jobId, e);
      return false;
    } catch (e) {
      log(' Reject job $jobId unexpected error: $e');
      return false;
    }
  }

  @override
  Future<bool> startJob(String jobId) async {
    try {
      log(' Starting job: $jobId');
      final response = await dio.post('/api/worker/jobs/$jobId/start');
      log(' Start job $jobId: ${response.statusCode}');
      return _isSuccess(response.statusCode);
    } on DioException catch (e) {
      _logDioError('start', jobId, e);
      return false;
    } catch (e) {
      log(' Start job $jobId unexpected error: $e');
      return false;
    }
  }

  @override
  Future<bool> expireJob(String jobId) async {
    try {
      log(' Expiring job: $jobId');
      final response = await dio.post('/api/worker/jobs/$jobId/expire');
      log(' Expire job $jobId: ${response.statusCode}');
      return _isSuccess(response.statusCode);
    } on DioException catch (e) {
      _logDioError('expire', jobId, e);
      return false;
    } catch (e) {
      log(' Expire job $jobId unexpected error: $e');
      return false;
    }
  }

  bool _isSuccess(int? statusCode) => statusCode == 200 || statusCode == 201;

  void _logDioError(String action, String jobId, DioException e) {
    log(' $action job $jobId failed:');
    log('   Type: ${e.type}');
    log('   Status: ${e.response?.statusCode}');
    log('   Message: ${e.message}');
    log('   Data: ${e.response?.data}');
  }
}
