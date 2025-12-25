import 'package:flutter/material.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';



class IncomingJobUIModel {
  final String jobId;
  final String service;
  final String issue;
  final double distanceKm;

  final String customerName;
  final String address;
  final int amount;
  final int expiresInSeconds;
  final List<String> imageUrls;
 final String? voiceNoteUrl; 
  IncomingJobUIModel({
    required this.jobId,
    required this.service,
    required this.issue,
    required this.distanceKm,

    required this.customerName,
    required this.address,
    required this.imageUrls,
     this.voiceNoteUrl,
    required this.amount,
    required this.expiresInSeconds
  });
}

class WorkerJobProvider extends ChangeNotifier {
  WorkerJobState state = WorkerJobState.waiting;
  IncomingJobUIModel? job;

   void simulateIncomingJob() {
    Future.delayed(const Duration(seconds: 2), () {
      job = IncomingJobUIModel(
        jobId: 'JOB001',
        service: 'AC Repair',
        issue: 'AC not cooling',
        distanceKm: 2.3,
        customerName: "John",
        address: "Chennai",
        imageUrls: [
          "kjhcblsjd/sjdbd/"
        ],
        amount: 700,
        expiresInSeconds: 30,
      );
      state = WorkerJobState.incoming;
      notifyListeners();
    });
  }

  void acceptJob() {
    state = WorkerJobState.waitingUserConfirmation;
    notifyListeners();


    Future.delayed(const Duration(seconds: 3), () {
      state = WorkerJobState.assigned;
      notifyListeners();
    });
  }

  void userRejectJob() {
    job = null;
    state = WorkerJobState.missed;
    notifyListeners();

    Future.delayed(Duration(seconds: 10),(){
      job=null;
      state= WorkerJobState.waiting;
      notifyListeners();
    });
  }
    void onJobExpired() {
 
  }
   void startJob() {
    state = WorkerJobState.active;
    notifyListeners();
  }
}

