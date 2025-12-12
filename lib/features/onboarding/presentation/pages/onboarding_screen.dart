import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahaai/core/enums/role.dart';



class OnboardingFlow extends StatefulWidget {
  final UserRole role;

  const OnboardingFlow({super.key, required this.role});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  late List<Map<String, String>> _slides;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    if (widget.role == UserRole.customer) {
      _slides = [
        {
          'title': 'Find Trusted Workers',
          'subtitle': 'Browse skilled professionals near you',
          'image': 'assets/images/onboarding1.jpeg',
        },
        { 
          'title': 'Book Services Easily',
          'subtitle': 'Schedule appointments at your convenience',
          'image': 'assets/images/onboardin2.png',
        },
        {
          'title': 'Track & Pay Securely',
          'subtitle': 'Monitor progress and pay with confidence',
          'image': 'assets/images/onboarding1.jpeg',
        },
      ];
    } else {
      _slides = [
        {
          'title': 'Grow Your Business',
          'subtitle': 'Reach more customers in your area',
          'image': 'assets/images/onboarding1.jpeg',
        },
        {
          'title': 'Manage Bookings',
          'subtitle': 'Accept jobs and set your schedule',
          'image': 'assets/images/onboarding1.jpeg',
        },
        {
          'title': 'Earn More',
          'subtitle': 'Get paid instantly for your services',
          'image': 'assets/images/onboarding1.jpeg',
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = const Color(0xFF009688);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 24),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Skip'),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return slidePannels(
                    title: _slides[index]['title']!,
                    subtitle: _slides[index]['subtitle']!,
                    imagePath: _slides[index]['image']!,
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => _buildIndicator(index == _currentPage, accentColor),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _slides.length - 1) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    } else {
                     context.go("/login");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: Text(_currentPage < _slides.length - 1 ? 'Next' : 'Get Started',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget slidePannels({required String title, required String subtitle, required String imagePath}) {
    final Color mainColor = const Color(0xFF466765);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: mainColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
  
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
