import 'package:dio/dio.dart';
import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/data/models/login_response_model.dart';
import 'package:sahaai/features/auth/data/models/otp_veryfy_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_response_model.dart';
import 'package:sahaai/features/auth/data/models/resend_otp_request_model.dart';
import 'package:sahaai/features/auth/data/models/worker_register_response_model.dart';
import 'package:sahaai/features/home/data/models/home_service_model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

 
  Future<Response> _post(String url, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(url, data: data);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    }
  }
  Future<RegisterResponseModel> registerUser(RegisterRequestModel model) async {
    final response = await _post(
      'UserAuth/register',
      data: model.toJson(),
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      throw Exception("User registration failed");
    }
  }

 
  Future<WorkerRegisterResponseModel> registerWorker(RegisterRequestModel model) async {
    final response = await _post(
      '/auth/worker/register',
      data: model.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
   return WorkerRegisterResponseModel.fromJson(response.data);
     } else {
      throw Exception("Worker registration failed");
    }
  }

  Future<LoginResponseModel> loginUser(LoginRequestModel model) async {
    final response = await _post(
      '/auth/user/login',
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      throw Exception("User login failed");
    }
  }

  Future<Map<String, dynamic>> loginWorker(LoginRequestModel model) async {
    final response = await _post(
      '/auth/worker/login',
      data: model.toJson(),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Worker login failed");
    }
  }


  Future<Map<String, dynamic>> verifyOtp(OtpVerifyRequestModel model) async {
    final response = await _post(
      '/auth/verify-otp', 
      data: model.toJson(),
    );if (response.statusCode == 200) {
      return response.data; 
    } else {
  throw Exception('OTP verification failed');
    }


  }

  
Future<Map<String, dynamic>> resendOtp(ResendOtpRequestModel model) async {
  final response = await _post('/auth/resend-otp', data: model.toJson());
  if (response.statusCode == 200) {
    return response.data;
  } else {
    throw Exception('Resend OTP failed');
  }
}
}


// import 'package:dio/dio.dart';
// import 'package:sahaai/features/home/data/models/home_service_model.dart';

class HomeService {
  final Dio _dio;

  HomeService(this._dio);

  Future<Response> _get(String url) async {
    try {
      return await _dio.get(url);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    }
  }

  Future<List<ServiceModel>> getServices() async {
    final response = await _get('/services'); 

    if (response.statusCode == 200) {
      final List<dynamic> dataList = response.data['data'];
      return dataList
          .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load services');
    }
  }
}

