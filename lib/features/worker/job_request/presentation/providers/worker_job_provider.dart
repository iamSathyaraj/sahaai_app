// import 'package:flutter/material.dart';
// import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';



// class IncomingJobUIModel {
//   final String jobId;
//   final String service;
//   final String issue;
//   final double distanceKm;

//   final String customerName;
//   final String address;
//   final int amount;
//   final int expiresInSeconds;
//   final List<String> imageUrls;
//  final String? voiceNoteUrl; 
//   IncomingJobUIModel({
//     required this.jobId,
//     required this.service,
//     required this.issue,
//     required this.distanceKm,

//     required this.customerName,
//     required this.address,
//     required this.imageUrls,
//      this.voiceNoteUrl,
//     required this.amount,
//     required this.expiresInSeconds
//   });
// }

// class WorkerJobProvider extends ChangeNotifier {
//   WorkerJobState state = WorkerJobState.waiting;
//   IncomingJobUIModel? job;

//    void simulateIncomingJob() {
//     Future.delayed(const Duration(seconds: 2), () {
//       job = IncomingJobUIModel(
//         jobId: 'JOB001',
//         service: 'AC Repair',
//         issue: 'AC not cooling',
//         distanceKm: 2.3,
//         customerName: "John",
//         address: "Chennai",
//         imageUrls: [
//           "kjhcblsjd/sjdbd/"
//         ],
//         amount: 700,
//         expiresInSeconds: 30,
//       );
//       state = WorkerJobState.incoming;
//       notifyListeners();
//     });
//   }

//   void acceptJob() {
//     state = WorkerJobState.waitingUserConfirmation;
//     notifyListeners();


//     Future.delayed(const Duration(seconds: 3), () {
//       state = WorkerJobState.assigned;
//       notifyListeners();
//     });
//   }

//   void userRejectJob() {
//     job = null;
//     state = WorkerJobState.missed;
//     notifyListeners();

//     Future.delayed(Duration(seconds: 10),(){
//       job=null;
//       state= WorkerJobState.waiting;
//       notifyListeners();
//     });
//   }
//     void onJobExpired() {
 
//   }
//    void startJob() {
//     state = WorkerJobState.active;
//     notifyListeners();
//   }
// }

// presentation/providers/worker_job_provider.dart
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';
// import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';
// import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

// class WorkerJobProvider extends ChangeNotifier {
//   final JobRepository _repository;

//    int? _secondsRemaining;
//      Timer? _countdownTimer; // ✅ Provider-controlled timer

//   int? get secondsRemaining => _secondsRemaining;
//   bool get isCountingDown => _secondsRemaining != null && _secondsRemaining! > 0;
  
//   // State
//   JobEntity? _job;
//   WorkerJobState _state = WorkerJobState.waiting;
//   bool _isLoading = false;
//   String? _errorMessage;
//   StreamSubscription? _jobStatusSubscription;

//   // Public getters
//   JobEntity? get job => _job;
//   WorkerJobState get state => _state;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get hasIncomingJob => _job != null && _state == WorkerJobState.incoming;
//   bool get isJobAssigned => _state == WorkerJobState.assigned;
//   bool get isJobActive => _state == WorkerJobState.active;

//   WorkerJobProvider(this._repository) {
//     _initStreams();
//   }

//   // Initialize streams
//   // void _initStreams() {
//   //   // Listen for incoming jobs (SignalR)
//   //   _repository.listenIncomingJob().listen(
//   //     (entity) {
//   //       print(' New job incoming: ${entity?.jobId}');
//   //       _job = entity;
//   //       _state = WorkerJobState.incoming;
//   //       _errorMessage = null;
//   //       notifyListeners();
//   //     },
//   //     onError: (error) {
//   //       _errorMessage = 'Failed to receive jobs: $error';
//   //       notifyListeners();
//   //     },
//   //   );
//   // }

//   void _initStreams() {
//     _repository.listenIncomingJob().listen((entity) {
//       _job = entity;
//       _secondsRemaining = (entity!.expiresAt.difference(DateTime.now()).inSeconds).clamp(0, 300);
//       _state = WorkerJobState.incoming;
//       _startCountdownTimer(); // ✅ Start real countdown
//       notifyListeners();
//     });
//   }

//     void _startCountdownTimer() {
//     _countdownTimer?.cancel();
//     if (_secondsRemaining == null || _secondsRemaining! <= 0) return;

//     _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_secondsRemaining! <= 1) {
//         timer.cancel();
//         _handleJobExpired(); // Auto expire
//       } else {
//         _secondsRemaining = _secondsRemaining! - 1;
//         notifyListeners();
//       }
//     });
//   }

//    Future<void> _handleJobExpired() async {
//     if (_job != null) {
//       await _repository.expireJob(_job!.jobId);
//       _reset();
//     }
//   }

//   // Accept job
//   Future<void> acceptJob() async {
//       _countdownTimer?.cancel(); // ✅ STOP COUNTDOWN
//     _secondsRemaining = null;
//     if (_job == null) return;
    
//     _setLoading(true);
//     _state = WorkerJobState.waitingUserConfirmation;
//     notifyListeners();

//     try {
//       print('📤 Accepting job: ${_job!.jobId}');
//       final success = await _repository.acceptJob(_job!.jobId);
//       if (success) {
//         _state = WorkerJobState.assigned;
//         _listenToJobStatus(); // Start listening for updates
//         _errorMessage = null;
//         print('✅ Job accepted: ${_job!.jobId}');
//       } else {
//         _state = WorkerJobState.incoming;
//         _errorMessage = 'Failed to accept job';
//       }
//     } catch (e) {
//       _state = WorkerJobState.incoming;
//       _errorMessage = 'Network error: $e';
//       print('❌ Accept failed: $e');
//     } finally {
//       _setLoading(false);
//       notifyListeners();
//     }
//   }

//   // Reject job
//   Future<void> rejectJob() async {
//     if (_job == null) return;
    
//     try {
//       print('📤 Rejecting job: ${_job!.jobId}');
//       await _repository.rejectJob(_job!.jobId);
//       _reset();
//       print('✅ Job rejected');
//     } catch (e) {
//       _errorMessage = 'Failed to reject job';
//       notifyListeners();
//       print('❌ Reject failed: $e');
//     }
//   }

//   // Start job
//   Future<void> startJob() async {
//     if (_job == null) return;
    
//     _setLoading(true);
//     notifyListeners();

//     try {
//       print('📤 Starting job: ${_job!.jobId}');
//       final success = await _repository.startJob(_job!.jobId);
//       if (success) {
//         _state = WorkerJobState.active;
//         _errorMessage = null;
//         print('✅ Job started');
//       } else {
//         _errorMessage = 'Failed to start job';
//       }
//     } catch (e) {
//       _errorMessage = 'Network error: $e';
//       print('❌ Start failed: $e');
//     } finally {
//       _setLoading(false);
//       notifyListeners();
//     }
//   }

//   // Listen to job status updates
//   void _listenToJobStatus() {
//     _jobStatusSubscription?.cancel();
//     if (_job?.jobId != null) {
//       _jobStatusSubscription = _repository.listenJobStatus(_job!.jobId).listen(
//         (status) {
//           print('📱 Status update: ${_job!.jobId} → $status');
//           _state = status;
//           notifyListeners();
//         },
//         onError: (error) {
//           _errorMessage = 'Status update failed: $error';
//           notifyListeners();
//         },
//       );
//     }
//   }

//   // Reset to waiting
//   void reset() {
//     _jobStatusSubscription?.cancel();
//     _reset();
//   }

//   void _reset() {
//     _job = null;
//     _state = WorkerJobState.waiting;
//     _errorMessage = null;
//     _setLoading(false);
//     notifyListeners();
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _countdownTimer?.cancel();
//     _jobStatusSubscription?.cancel();
//     super.dispose();
//   }
// }


// presentation/providers/worker_job_provider.dart
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sahaai/features/worker/job_request/domain/entities/worker_job_entity.dart';
import 'package:sahaai/features/worker/job_request/domain/repositories/job_repositories.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

class WorkerJobProvider extends ChangeNotifier {
  final JobRepository _repository;

  int? _secondsRemaining;
  Timer? _countdownTimer;
  int? get secondsRemaining => _secondsRemaining;
  bool get isCountingDown => _secondsRemaining != null && _secondsRemaining! > 0;
  
  JobEntity? _job;
  WorkerJobState _state = WorkerJobState.waiting;
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription? _jobStatusSubscription;

  JobEntity? get job => _job;
  WorkerJobState get state => _state;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasIncomingJob => _job != null && _state == WorkerJobState.incoming;
  bool get isJobAssigned => _state == WorkerJobState.assigned;
  bool get isJobActive => _state == WorkerJobState.active;

  WorkerJobProvider(this._repository) {
    _initStreams();
  }

  //  Real SignalR stream
  void _initStreams() {
    _repository.listenIncomingJob().listen(
      (entity) {
        log('New job incoming: ${entity?.jobId}');
        _job = entity;
        _secondsRemaining = (entity!.expiresAt.difference(DateTime.now()).inSeconds).clamp(0, 300);
        _state = WorkerJobState.incoming;
        _startCountdownTimer(); 
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Failed to receive jobs: $error';
        log('Stream error: $error');
        notifyListeners();
      },
    );
  }

  //  1-second countdown
  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    if (_secondsRemaining == null || _secondsRemaining! <= 0) return;

    log(' Starting countdown: $_secondsRemaining seconds');
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining! <= 1) {
        timer.cancel();
        _handleJobExpired(); // Auto expire of job
      } else {
        _secondsRemaining = _secondsRemaining! - 1;
        notifyListeners();
      }
    });
  }

  Future<void> _handleJobExpired() async {
    log('Job EXPIRED: ${_job?.jobId}');
    if (_job != null) {
      try {
        await _repository.expireJob(_job!.jobId);
        log(' Backend notified: Job ${_job!.jobId} expired');
      } catch (e) {
        log('Backend expire failed (non-critical): $e');
      }
      _reset();
    }
  }

  Future<void> acceptJob() async {
    _countdownTimer?.cancel(); 
    _secondsRemaining = null;
    if (_job == null) return;
    
    _setLoading(true);
    _state = WorkerJobState.waitingUserConfirmation;
    notifyListeners();

    try {
      log(' Accepting job: ${_job!.jobId}');
      final success = await _repository.acceptJob(_job!.jobId);
      if (success) {
        _state = WorkerJobState.assigned;
        _listenToJobStatus();
        _errorMessage = null;
        log('Job accepted: ${_job!.jobId}');
      } else {
        _state = WorkerJobState.incoming;
        _errorMessage = 'Job unavailable ';
        log(' Job accept failed (backend returned false)');
      }
    } catch (e) {
      _state = WorkerJobState.incoming;
      _errorMessage = 'Network error: $e';
      log(' Accept failed: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> rejectJob() async {
    _countdownTimer?.cancel(); 
    if (_job == null) return;
    
    try {
      log(' Rejecting job: ${_job!.jobId}');
      await _repository.rejectJob(_job!.jobId);
      _reset();
      log(' Job rejected: ${_job!.jobId}');
    } catch (e) {
      _errorMessage = 'Failed to reject job';
      log(' Reject failed: $e');
      notifyListeners();
    }
  }

  Future<void> startJob() async {
    if (_job == null) return;
    
    _setLoading(true);
    notifyListeners();

    try {
      log(' Starting job: ${_job!.jobId}');
      final success = await _repository.startJob(_job!.jobId);
      if (success) {
        _state = WorkerJobState.active;
        _errorMessage = null;
        log(' Job started: ${_job!.jobId}');
      } else {
        _errorMessage = 'Failed to start job';
      }
    } catch (e) {
      _errorMessage = 'Network error: $e';
      log(' Start failed: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _listenToJobStatus() {
    _jobStatusSubscription?.cancel();
    if (_job?.jobId != null) {
      _jobStatusSubscription = _repository.listenJobStatus(_job!.jobId).listen(
        (status) {
          log(' Status update: ${_job!.jobId} → $status');
          _state = status;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Status update failed: $error';
          log(' Status stream error: $error');
          notifyListeners();
        },
      );
    }
  }

  void reset() {
    _jobStatusSubscription?.cancel();
    _countdownTimer?.cancel();
    _reset();
  }

  void _reset() {
    _job = null;
    _state = WorkerJobState.waiting;
    _secondsRemaining = null;
    _errorMessage = null;
    _setLoading(false);
    notifyListeners();
    log(' Reset to waiting state');
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _jobStatusSubscription?.cancel();
    super.dispose();
  }
}
