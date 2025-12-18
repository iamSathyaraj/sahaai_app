
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/issue_tracking_provider.dart';

class AcceptedWorkersScreen extends StatelessWidget {
  final String requestId;

  const AcceptedWorkersScreen({
    super.key,
    required this.requestId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IssueTrackingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Worker'),
      ),
      body: Builder(
        builder: (_) {
          if (provider.workers.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 80),
                Center(
                  child: Text('No workers have accepted yet.'),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: provider.workers.length,
            itemBuilder: (_, index) {
              final w = provider.workers[index];
              return ListTile(
                title: Text(w.name),
                subtitle: Text('⭐ ${w.rating} • ${w.distanceKm} km'),
                trailing: ElevatedButton(
                  onPressed: provider.isSelecting
                      ? null
                      : () async {
                          // UI-only: for now just show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Selected worker: ${w.name} (UI branch, no backend yet)',
                              ),
                            ),
                          );
                        },
                  child: provider.isSelecting
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Select'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<IssueTrackingProvider>().simulateWorkerComing(),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
