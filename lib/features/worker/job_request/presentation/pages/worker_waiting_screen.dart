import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/worker/job_request/presentation/providers/worker_job_provider.dart';
import 'package:sahaai/features/worker/job_request/presentation/enums/worker_job_state.dart';

class WorkerWaitingScreen extends StatelessWidget {
  const WorkerWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<WorkerJobProvider>();

    if (jobProvider.state == WorkerJobState.waiting &&
        jobProvider.job == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        jobProvider.simulateIncomingJob();
      });
    }

     WidgetsBinding.instance.addPostFrameCallback((_) {
    if (jobProvider.state == WorkerJobState.incoming) {
      context.go('/worker/incoming');
    }
  });


    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statusChip(),
                  const Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.white70, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Chennai',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            Stack(
              alignment: Alignment.center,
              children: [
                radarCircle(140),
                radarCircle(100),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.work, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Searching for jobs nearby',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You’ll be notified instantly when a job arrives',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.visibility, color: Colors.greenAccent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You are visible to customers within your service area',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // UI phase → no backend logic yet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Offline feature coming soon'),
                      ),
                    );
                  },
                  child: const Text(
                    'GO OFFLINE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withAlpha(60),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: Colors.greenAccent),
          SizedBox(width: 6),
          Text(
            'ONLINE',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget radarCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.greenAccent.withAlpha(100),
          width: 2,
        ),
      ),
    );
  }
}
