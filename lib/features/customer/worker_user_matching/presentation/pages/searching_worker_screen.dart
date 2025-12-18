
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/issue_tracking_provider.dart';

class SearchingWorkerScreen extends StatefulWidget {
  final String requestId;
  const SearchingWorkerScreen({super.key, required this.requestId});

  @override
  State<SearchingWorkerScreen> createState() => _SearchingWorkerScreenState();
}

class _SearchingWorkerScreenState extends State<SearchingWorkerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IssueTrackingProvider>();

    final text =
        provider.status == ServiceRequestStatus.expandingRadius
            ? "Expanding search area to find more workers..."
            : "Searching nearby workers...";

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black87),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Finding Workers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      RotationTransition(
                        turns: _controller,
                        child: const Icon(
                          Icons.sync,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        text,
                        style: const TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextButton( 
                        onPressed: () =>
                            context.read<IssueTrackingProvider>()
                                .simulateExpandRadius(),
                        child: const Text(
                          'Simulate Expand Radius',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<IssueTrackingProvider>()
                                .simulateWorkerComing(),
                        child: const Text(
                          'Simulate Worker Found',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<IssueTrackingProvider>()
                                .simulateNoWorkers(),
                        child: const Text(
                          'Simulate No Workers',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

