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
      body: RefreshIndicator(
        onRefresh: () => provider.refreshCandidates(requestId),
        child: Builder(
          builder: (_) {
            if (provider.isLoading && provider.workers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage != null &&
                provider.workers.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 80),
                  Center(child: Text(provider.errorMessage!)),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          provider.refreshCandidates(requestId),
                      child: const Text('Retry'),
                    ),
                  ),
                ],
              );
            }

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
                            final ok = await provider.selectWorker(
                              requestId,
                              w.id,
                            );
                            if (!ok && provider.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(provider.errorMessage!),
                                ),
                              );
                            } else if (ok && context.mounted) {
                              Navigator.pop(context);
                            }
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
      ),
    );
  }
}
