import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/worker_job_provider.dart';
import 'accept_reject_buttons.dart';
import 'countdown_timer.dart';
import 'job_detail_row.dart';

class IncomingJobCard extends StatelessWidget {
  final IncomingJobUIModel job;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onExpired;
  

  const IncomingJobCard({
    super.key,
    required this.job,
    required this.onAccept,
    required this.onReject,
    required this.onExpired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withAlpha(50)) ,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'New Job Request',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          JobDetailRow(label: 'Service', value: job.service),
          JobDetailRow(label: 'Issue', value: job.issue),
          JobDetailRow(
            label: 'Distance',
            value: '${job.distanceKm.toStringAsFixed(1)} km',
          ),
          JobDetailRow(
            label: 'Earnings',
            value: '₹${job.amount}',
            valueColor: Colors.greenAccent,
          ),
           
          const SizedBox(height: 16),

          CountdownTimer(
            seconds: job.expiresInSeconds,
            onExpired: onExpired,
          ),

          const SizedBox(height: 22),

          AcceptRejectButtons(
            onAccept: (){
           context.read<WorkerJobProvider>().acceptJob();  
                     },
            onReject: (){
            },
          ),
        ],
      ), 
    );
  }
}
