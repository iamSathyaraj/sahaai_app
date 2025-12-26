import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

abstract class JobRepository {
  Stream<JobEntity?> listenIncomingJob();
  Future<bool> acceptJob(String jobId);
  Future<bool> rejectJob(String jobId);
  Future<bool> startJob(String jobId);
  Future<bool> expireJob(String jobId);

  Stream<WorkerJobState> listenJobStatus(String jobId);
}
