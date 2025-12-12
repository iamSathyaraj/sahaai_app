import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahaai/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:sahaai/core/enums/role.dart';
import 'package:sahaai/features/onboarding/presentation/widgets/custom_role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  final Color mainColor = const Color(0xFF466765);
  final Color accentColor = const Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.handyman_outlined, size: 80, color: mainColor),
              const SizedBox(height: 24),
              Text(
                'Sahaai',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: mainColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Service Partner',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 60),
              Text(
                'Continue as',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: mainColor),
              ),
              const SizedBox(height: 32),

              RoleCard(
                title: 'Customer',
                description: 'Find and hire skilled workers for your needs',
                icon: Icons.person_outline,
                color: accentColor,
                onTap: () => context.go('/onboarding-customer')
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (_) => OnboardingFlow(role: UserRole.worker)),
                //   ); 
                // },
              ),
              const SizedBox(height: 20),

              RoleCard(
                title: 'Worker',
                description: 'Offer your services',
                icon: Icons.work_outline,
                color: mainColor,
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (_) => OnboardingFlow(role: UserRole.worker)),
                //   );
                // },
                onTap: () => context.go('/onboarding-worker')
              ),
            ],
          ),
        ),
      ),
    );
  }
}

