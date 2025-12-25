import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/job_assigned_screen.dart';
import '../providers/worker_job_provider.dart';
import '../widgets/incoming_job_card.dart';

class IncomingJobScreen extends StatelessWidget {
  const IncomingJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkerJobProvider>();
    final job = provider.job;

    if (job == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(color: Colors.black87),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child:
                   IncomingJobCard(
              job: job,
               onExpired: () {
               provider.onJobExpired();
                context.go('/worker/assigned');
                 },
               onAccept: () {

                provider.acceptJob();
                  context.go('/worker/confirmation');
                 },
               onReject: () {
                 provider.userRejectJob();
                 context.go('/worker/missed');
  },
),
                //  IncomingJobCard(
                //   job: job,
                //   onExpired: provider.onJobExpired,
                //   onAccept: provider.acceptJob,
                //   onReject: provider.userRejectJob,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
