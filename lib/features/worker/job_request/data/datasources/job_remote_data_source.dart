// import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  // Future<JobModel?> fetchIncomingJob();
  Future<bool> acceptJob(String jobId);
  Future<bool> rejectJob(String jobId);
  Future<bool> startJob(String jobId);
 Future<bool> expireJob(String jobId); 

}
