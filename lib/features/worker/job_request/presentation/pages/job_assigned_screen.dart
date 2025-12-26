
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/worker_job_provider.dart';

class JobAssignedScreen extends StatelessWidget {
  const JobAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkerJobProvider>();
    final job = provider.job!;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Job Assigned'),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.check_circle,
                      color: Colors.greenAccent, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You have been selected for this job',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            _detailCard(
              title: 'Job Details',
              children: [
                _row('Customer', job.customerName),
                _row('Service', job.serviceType),
                _row('Issue', job.issueDescription),
                _row('Address', job.area),
              ],
            ),

            const SizedBox(height: 16),
            if (job.imageUrls.isNotEmpty) ...[
              _detailCard (
                title: 'Issue Images',
                children: [
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: job.imageUrls.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            job.imageUrls[index],
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // _detailCard(
            //   title: 'Earnings',
            //   children: [
            //     Text(
            //       '₹${job.amount}',
            //       style: const TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.greenAccent,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 23, 174, 101),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: provider.startJob,
                child: const Text(
                  'START WORK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
