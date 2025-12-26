// data/datasources/worker_job_signalr_datasource_impl.dart
import 'dart:async';
import 'dart:developer' as developer;
import 'package:sahaai/features/worker/job_request/data/models/job_model.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'worker_job_signalr_datasource.dart';

class WorkerJobSignalRDataSourceImpl implements WorkerJobSignalRDataSource {
  final String hubUrl;
  HubConnection? _hubConnection;
  final StreamController<JobModel?> _incomingJobsController = StreamController<JobModel?>.broadcast();
  final Map<String, StreamController<WorkerJobState>> _jobStatusControllers = {};

  WorkerJobSignalRDataSourceImpl({required this.hubUrl}) {
    _initializeSignalR();
  }

  void _initializeSignalR() {
    _hubConnection = HubConnectionBuilder()
        .withUrl(hubUrl)
        .withAutomaticReconnect()
        .build();

    _hubConnection!.start()?.catchError((error) {
      developer.log(' SignalR connection failed: $error');
      _incomingJobsController.addError('Connection failed: $error');
    }).then((_) {
      developer.log(' SignalR connected to $hubUrl');
      _setupEventListeners();
    });
  }

  void _setupEventListeners() {
    //  New job listener
    _hubConnection!.on('NewJobAvailable', (List<Object?>? message) {
      try {
if (message?.isNotEmpty == true && message![0] != null) {
            final jobModel = JobModel.fromJson(message[0] as Map<String, dynamic>);
          _incomingJobsController.add(jobModel);
          developer.log(' New job received: ${jobModel.id}');
        }
      } catch (e) {
        developer.log(' Parse job error: $e');
      }
    });

    //  Job status listener
    _hubConnection!.on('JobStatusUpdated', (List<Object?>? message) {
      try {
if (message?.isNotEmpty == true && message![0] != null) {
            final data = message[0] as Map<String, dynamic>;
          final jobId = data['jobId'] as String?;
          final statusString = data['status'] as String?;
          
          if (jobId != null && statusString != null) {
final status = _parseStatusSafe(statusString);          
  _jobStatusControllers[jobId]?.add(status);
            developer.log(' Status update: $jobId → $statusString');
          }
        }
      } catch (e) {
        developer.log(' Parse status error: $e');
      }
    });
  }
WorkerJobState _parseStatusSafe(String statusString) {
  try {
    return WorkerJobState.values.byName(statusString.toLowerCase());
  } catch (e) {
    developer.log(' Unknown status "$statusString"  assigned', name: 'SignalR');
    return WorkerJobState.assigned;
  }
}


  @override
  Stream<JobModel?> listenIncomingJobs() => _incomingJobsController.stream;

  @override
  Stream<WorkerJobState> listenJobStatus(String jobId) {
    return _jobStatusControllers.putIfAbsent(
      jobId, 
      () => StreamController<WorkerJobState>.broadcast(),
    ).stream;
  }

  void dispose() {
    _incomingJobsController.close();
    _jobStatusControllers.values.forEach((c) => c.close());
    _jobStatusControllers.clear();
    _hubConnection?.stop();
    _hubConnection = null;
  }
}
