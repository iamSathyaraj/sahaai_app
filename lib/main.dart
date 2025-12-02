
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/app.dart';
import 'package:sahaai/core/network/api_service.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sahaai/features/auth/domain/usecases/login_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_usecase.dart';
import 'package:sahaai/features/auth/domain/usecases/register_worker_usecase.dart';
import 'package:sahaai/features/auth/presentation/provider/login_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/otp_provider.dart';
import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
import 'package:sahaai/features/home/data/repositories/home_repository_impl.dart';
import 'package:sahaai/features/home/domain/usecases/get_service_usecase.dart';

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
      ],
      child: const App(),
    ),
  );
}

