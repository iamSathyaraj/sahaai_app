
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/app.dart';
import 'package:sahaai/core/network/api_service.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/core/token_storage.dart';
import 'package:sahaai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sahaai/features/auth/domain/usecases/login_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_worker_usecase.dart';
import 'package:sahaai/features/auth/presentation/provider/login_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/otp_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
import 'package:sahaai/features/customer/worker_user_matching/data/datasources/issue_matching_remote_datasource.dart';
import 'package:sahaai/features/customer/worker_user_matching/data/datasources/issue_matching_signalr_datasource.dart';
import 'package:sahaai/features/customer/worker_user_matching/data/repositories/issue_matching_repository_impl.dart';
import 'package:sahaai/features/customer/worker_user_matching/domain/usecases/get_issue_candidates_usecase.dart';
import 'package:sahaai/features/customer/worker_user_matching/domain/usecases/get_issue_status_usecase.dart';
import 'package:sahaai/features/customer/worker_user_matching/domain/usecases/listen_issue_status_usecase.dart';
import 'package:sahaai/features/customer/worker_user_matching/domain/usecases/listen_worker_accepted_usecase.dart';
import 'package:sahaai/features/customer/worker_user_matching/domain/usecases/select_worker_usecase.dart';
import 'package:sahaai/features/customer/worker_user_matching/presentation/providers/issue_tracking_provider.dart';
import 'package:sahaai/features/home/data/repositories/home_repository_impl.dart';
import 'package:sahaai/features/home/domain/usecases/get_service_usecase.dart';
import 'package:sahaai/features/worker/home/data/datasources/worker_status_remote_datasource_impl.dart';
import 'package:sahaai/features/worker/home/data/repositories/worker_status_repository_impl.dart';
import 'package:sahaai/features/worker/home/domain/usecases/worker_go_offline_usecase.dart';
import 'package:sahaai/features/worker/home/domain/usecases/worker_go_online_usecase.dart';
import 'package:sahaai/features/worker/home/presentation/providers/worker_status_provider.dart';
import 'package:sahaai/features/worker/job_request/presentation/providers/worker_job_provider.dart';


void main() {
  final client = DioClient(baseUrl: "http://192.168.1.90:5016/api/");
  final authService = AuthService(client.dio);
  final authRepository = AuthRepositoryImpl(authService);
  final homeService = HomeService(client.dio);
  final homeRepository = HomeRepositoryImpl(homeService);
  final getServicesUseCase = GetServiceUsecase(homeRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final registerWorkerUseCase = RegisterWorkerUseCase(authRepository);
  final loginUseCase = LoginUseCase(authRepository);
  final otpVerifyUseCase = VerifyOtpUseCase(authRepository);

  final workerStatusRemote = WorkerStatusRemoteDataSourceImpl(client);
final workerStatusRepository = WorkerStatusRepositoryImpl(workerStatusRemote);
final workerGoOnlineUseCase = WorkerGoOnlineUseCase(workerStatusRepository);
final workerGoOfflineUseCase = WorkerGoOfflineUseCase(workerStatusRepository);


final tokenStorage = TokenStorage();
final issueMatchingRemote = IssueMatchingRemoteDataSource(client.dio);
final issueMatchingSignalR = IssueMatchingSignalRDataSource(
  hubUrl: "http://192.168.1.90:5016/hubs/issue",
  getToken: TokenStorage.getAccessToken,  // ✅ Uses your FlutterSecureStorage
);

final issueMatchingRepository = IssueMatchingRepositoryImpl(
  remote: issueMatchingRemote,
  signalR: issueMatchingSignalR,
);

final getIssueStatusUseCase = GetIssueStatusUseCase(issueMatchingRepository);
final getIssueCandidatesUseCase = GetIssueCandidatesUseCase(issueMatchingRepository);
final selectWorkerUseCase = SelectWorkerUseCase(issueMatchingRepository);
final listenIssueStatusUseCase = ListenIssueStatusUseCase(issueMatchingRepository);
final listenWorkerAcceptedUseCase = ListenWorkerAcceptedUseCase(issueMatchingRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(registerUseCase,
           registerWorkerUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(loginUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => OtpProvider(otpVerifyUseCase),
        ),


        ChangeNotifierProvider(
         create: (_) => WorkerStatusProvider(
            goOnlineUseCase: workerGoOnlineUseCase,
               goOfflineUseCase: workerGoOfflineUseCase,
           ),
         ),

         ChangeNotifierProvider(
        create: (_) => IssueTrackingProvider(
        getIssueStatusUseCase: getIssueStatusUseCase,
    getIssueCandidatesUseCase: getIssueCandidatesUseCase,
    selectWorkerUseCase: selectWorkerUseCase,
    listenIssueStatusUseCase: listenIssueStatusUseCase,
    listenWorkerAcceptedUseCase: listenWorkerAcceptedUseCase,
  ),
),
ChangeNotifierProvider(
  create: (_)=>WorkerJobProvider())

      ],
      child: const App(),
    ),
  );
}

