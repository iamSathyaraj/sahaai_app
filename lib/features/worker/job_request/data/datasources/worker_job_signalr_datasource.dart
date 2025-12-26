import 'package:sahaai/features/worker/job_request/data/models/job_model.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';
abstract class WorkerJobSignalRDataSource {
  Stream<JobModel?> listenIncomingJobs();
  Stream<WorkerJobState> listenJobStatus(String jobId);
}
