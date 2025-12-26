import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';
import '../providers/worker_job_provider.dart';
import '../widgets/incoming_job_card.dart';

class IncomingJobScreen extends StatelessWidget {
  const IncomingJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkerJobProvider>(
      builder: (context, provider, child) {
        final job = provider.job;

        if (job == null || provider.state != WorkerJobState.incoming) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/worker/waiting');
          });
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
                    child: IncomingJobCard(
                      job: job,
                      secondsRemaining: provider.secondsRemaining ?? 0,
                      isLoading: provider.isLoading,
                      onExpired: () {
                        provider.reset();
                        context.go('/worker/missed');
                      },
                      onAccept: () async {
                        await provider.acceptJob();
                        if (provider.state == WorkerJobState.assigned || 
                            provider.state == WorkerJobState.waitingUserConfirmation) {
                          context.go('/worker/confirmation');
                        }
                      },
                      onReject: () async {
                        await provider.rejectJob();
                        context.go('/worker/missed');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

