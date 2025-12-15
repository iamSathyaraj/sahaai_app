import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueSearchingScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const IssueSearchingScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const mainColor = Color(0xFF466765);

    final LatLng center = LatLng(latitude, longitude);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('issue_location'),
                  position: center,
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Searching workers nearby...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 18),
                  _AnimatedGlowButton(),
                  SizedBox(height: 28),
                  Text(
                    "Your request has been sent to available workers in your area. "
                    "You will be notified once a worker accepts.",
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.19,
            right: size.width * 0.13,
            child: FloatingActionButton(
              backgroundColor: mainColor,
              mini: true,
              onPressed: () {
              },
              child: const Icon(Icons.my_location, color: Colors.white),
              elevation: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedGlowButton extends StatefulWidget {
  const _AnimatedGlowButton();

  @override
  State<_AnimatedGlowButton> createState() => _AnimatedGlowButtonState();
}

class _AnimatedGlowButtonState extends State<_AnimatedGlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const Color alertColor = Color(0xffFF5656);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: alertColor,
          shadowColor: alertColor.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
          elevation: 8,
          shape: const CircleBorder(),
        ),
        onPressed: () {
        },
        child: const Icon(Icons.search, color: Colors.white, size: 30),
      ),
    );
  }
}
