import 'package:flutter/material.dart';
import 'package:sahaai/features/home/presentation/widgets/worker_assigned_card.dart';

class WorkerAssignedPage extends StatelessWidget {
  const WorkerAssignedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

          child: WorkerAssignedCard())
        ],
      ),
    );
  }
}