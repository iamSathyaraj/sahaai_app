import 'package:go_router/go_router.dart';
import 'package:sahaai/core/enums/role.dart';
import 'package:sahaai/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:sahaai/features/auth/presentation/pages/login_page.dart';
import 'package:sahaai/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:sahaai/features/auth/presentation/pages/register_page.dart';
import 'package:sahaai/features/shared/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash', 
    routes: [
        GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
        GoRoute(
        path: '/login',
        builder: (context, state) =>  LoginPage(),
      ),
    
        GoRoute(
        path: '/registration',
        builder: (context, state) =>  RegisterPage(),
      ),
        GoRoute(
        path: '/forgotpassword',
        builder: (context, state) =>  ForgotPasswordScreen(),
      ),
      GoRoute(
  path: '/otp-verify/:userId',
  builder: (context, state) {
    final userIds = state.pathParameters['userId']!;
        final userId = int.tryParse(userIds);
    return OtpVerificationPage(userId: userId!);
  },
),



    ],
  );
}
