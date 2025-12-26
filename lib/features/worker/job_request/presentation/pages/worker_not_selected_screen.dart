import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissedJobScreen extends StatelessWidget {
  const MissedJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        context.go('/worker/waiting');
      });
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.info_outline, color: Colors.orange, size: 48),
            SizedBox(height: 16),
            Text(
              'Job Assigned to Another Worker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You’ll be notified when a new job is available.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
