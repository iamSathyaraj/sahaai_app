import 'package:sahaai/features/worker/job_request/data/datasources/job_remote_data_source.dart';
import 'package:sahaai/features/worker/job_request/data/datasources/worker_job_signalr_datasource.dart';
import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';
import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remote;
  final WorkerJobSignalRDataSource signalR;

  JobRepositoryImpl({
    required this.remote,
    required this.signalR,
  });

  @override
  Future<bool> acceptJob(String jobId) => remote.acceptJob(jobId);

  @override
  Future<bool> rejectJob(String jobId) => remote.rejectJob(jobId);

  @override
  Future<bool> startJob(String jobId) => remote.startJob(jobId);

    @override
  Future<bool> expireJob(String jobId) => remote.expireJob(jobId);


  @override
  Stream<JobEntity?> listenIncomingJob() =>
      signalR.listenIncomingJobs().map((m)=>m?.toEntity());

  @override
  Stream<WorkerJobState> listenJobStatus(String jobId) =>
      signalR.listenJobStatus(jobId);
}
