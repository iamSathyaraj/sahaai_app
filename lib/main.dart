import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/app.dart';
import 'package:sahaai/core/network/api_service.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/core/providers/location_provider.dart';
import 'package:sahaai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sahaai/features/auth/domain/usecases/login_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_worker_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/worker_login_usecase.dart';
import 'package:sahaai/features/auth/presentation/provider/login_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/otp_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/worker_login_provider.dart';
import 'package:sahaai/features/home/data/repositories/home_repository_impl.dart';
import 'package:sahaai/features/home/data/repositories/issue_repository_impl.dart';
import 'package:sahaai/features/home/data/repositories/location_repository_impl.dart';
// import 'package:sahaai/features/home/data/sources/issue_remote_data_source.dart';
import 'package:sahaai/features/home/data/sources/issue_remote_datasource_impl.dart';
import 'package:sahaai/features/home/data/sources/location_local_datasource.dart';
import 'package:sahaai/features/home/data/sources/location_remote_datasource.dart';
import 'package:sahaai/features/home/domain/usecases/create_issue_usecase.dart';
import 'package:sahaai/features/home/domain/usecases/get_service_usecase.dart';
import 'package:sahaai/features/home/presentation/provider/home_provider.dart';
import 'package:sahaai/features/home/presentation/provider/issue_provider.dart';

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
  // final loginUseCase = LoginUseCase(authRepository);
final workerLoginUseCase = WorkerLoginUseCase(authRepository);
// final registerUseCase = RegisterUseCase(authRepository);
// final registerWorkerUseCase = RegisterWorkerUseCase(authRepository);

  final otpVerifyUseCase = VerifyOtpUseCase(authRepository);
    final issueRemoteDataSource = IssueRemoteDataSourceImpl(client);
    final issueRepository = IssueRepositoryImpl(issueRemoteDataSource);
    final createIssueUseCase = CreateIssueUseCase(issueRepository);
  // final issueRemoteDS = IssueRemoteDataSourceImpl(dioc);
  // final issueRepository = IssueRepositoryImpl(issueRemoteDS);
  final locationRemoteDS = LocationRemoteDataSourceImpl(client);
  final locationLocalDS = LocationLocalDataSource();
  final locationRepository = LocationRepositoryImpl(locationRemoteDS,locationLocalDS);
  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegisterProvider(registerUseCase, registerWorkerUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(loginUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => OtpProvider(otpVerifyUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(locationRepository),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => IssueProvider(issueRepository),
        // ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(getServicesUseCase)
        ),
         ChangeNotifierProvider(create: (_) => IssueProvider(createIssueUseCase)),

//        ChangeNotifierProvider(
//   create: (_) => LoginProvider(loginUseCase),
// ),
ChangeNotifierProvider(
  create: (_) => WorkerLoginProvider(workerLoginUseCase),
),
      ],
      child: const App(),
    ),
  );
}

