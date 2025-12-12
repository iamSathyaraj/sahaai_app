import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainColor = Color(0xFF466765);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(6.5466, 3.3426), zoom: 14
              ),
              markers: {
                Marker(
                    markerId: MarkerId('me'),
                    position: LatLng(6.5466, 3.3426)
                )
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: 
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.15)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 16,
                    offset: Offset(0,6),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Searching Workers Nearby...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 18),
                  AnimatedGlowButton(),
                  SizedBox(height: 28),
                  Text(
                    "A request will be sent to all available workers in your area.",
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
              child: Icon(Icons.my_location, color: Colors.white),
              elevation: 6,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: mainColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

class AnimatedGlowButton extends StatefulWidget {
  @override
  State<AnimatedGlowButton> createState() => _AnimatedGlowButtonState();
}

class _AnimatedGlowButtonState extends State<AnimatedGlowButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color alertColor = Color(0xffFF5656);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1), vsync: this)..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0, end: 1.18).animate(CurvedAnimation(
        parent: _controller, curve: Curves.easeInOut));
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
          shadowColor: alertColor.withValues(),
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
          elevation: 8,
          shape: CircleBorder(),
        ),
        onPressed: () {},
        child: Icon(
          Icons.search
        ),
      ),
    );
  }
}
