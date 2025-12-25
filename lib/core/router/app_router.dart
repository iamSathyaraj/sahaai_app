import 'package:go_router/go_router.dart';
import 'package:sahaai/core/enums/role.dart';
import 'package:sahaai/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:sahaai/features/auth/presentation/pages/login_page.dart';
import 'package:sahaai/features/auth/presentation/pages/otp_verify_page.dart';
import 'package:sahaai/features/auth/presentation/pages/register_page.dart';
import 'package:sahaai/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:sahaai/features/onboarding/presentation/pages/role_selection_screen.dart';
import 'package:sahaai/features/shared/splash/presentation/pages/splash_screen.dart';
import 'package:sahaai/features/worker/home/presentation/pages/worker_online_status_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/current_job_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/incoming_job_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/job_assigned_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/waiting_user_confirmation_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/worker_not_selected_screen.dart';
import 'package:sahaai/features/worker/job_request/presentation/pages/worker_waiting_screen.dart';

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

GoRoute(
  path: '/roleSelection',
  builder: (context, state) =>
      const RoleSelectionScreen(),
),

GoRoute(
  path: '/onboarding-customer',
  builder: (context, state) =>
      const OnboardingFlow(role: UserRole.customer),
),
GoRoute(  
  path: '/onboarding-worker',
  builder: (context, state) =>
      const OnboardingFlow(role: UserRole.worker),
),

GoRoute(
      name: 'worker-status',
      path: '/worker-status',
      builder: (context, state) => const WorkerStatusScreen(),
    ),

    GoRoute(
  path: '/worker/waiting',
  builder: (_, __) => const WorkerWaitingScreen(),
),
GoRoute(
  path: '/worker/incoming',
  builder: (_, __) => const IncomingJobScreen(),
),
GoRoute(
  path: '/worker/confirmation',
  builder: (_, __) => const WaitingUserConfirmationScreen(),
),
GoRoute(
  path: '/worker/assigned',
  builder: (_, __) => const JobAssignedScreen(),
),
GoRoute(
  path: '/worker/missed',
  builder: (_, __) => const MissedJobScreen(),
),
// GoRoute(
//   path: '/worker/active',
//   builder: (_, __) => const CurrentJobScreen(),
// ),


//     GoRoute(
//   path: '/worker',
//   builder: (context, state) {
//     final jobState =
//         context.watch<WorkerJobProvider>().state;

//     switch (jobState) {
//       case WorkerJobState.waiting:
//         return const WorkerWaitingScreen();

//       case WorkerJobState.incoming:
//         return const IncomingJobScreen();

//       case WorkerJobState.waitingUserConfirmation:
//         return const WaitingUserConfirmationScreen();

//       case WorkerJobState.assigned:
//         return const JobAssignedScreen();

//       case WorkerJobState.rejectedByUser:
//         return const WorkerWaitingScreen(
//           message: 'Customer selected another worker',
//         );

//       case WorkerJobState.active:
//         return const CurrentJobScreen();
//     }
//   },
// ),

    ],
  );
}
