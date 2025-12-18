import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/customer/worker_user_matching/presentation/pages/accepted_worker_screen.dart';
import '../providers/issue_tracking_provider.dart';
import 'searching_worker_screen.dart';
import 'no_workers_screen.dart';

class IssueFlowScreen extends StatelessWidget {
  final String requestId;
  const IssueFlowScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IssueTrackingProvider>();

    if (provider.status == ServiceRequestStatus.noWorkersAvailable) {
      return NoWorkersScreen(requestId: requestId);
    }

    if (provider.hasWorkers) {
      return AcceptedWorkersScreen(requestId: requestId);
    }

    if (provider.isSearching ||
        provider.status == ServiceRequestStatus.pending) {
      return SearchingWorkerScreen(requestId: requestId);
    }

  

    return SearchingWorkerScreen(requestId: requestId);
  }
}
