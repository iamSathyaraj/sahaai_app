
  import 'package:sahaai/core/token_storage.dart';
import 'package:sahaai/features/auth/data/models/login_request_model.dart';
import 'package:sahaai/features/auth/data/models/login_response_model.dart';
  import 'package:sahaai/features/auth/data/models/otp_veryfy_request_model.dart';
  import 'package:sahaai/features/auth/data/models/register_request_model.dart';
import 'package:sahaai/features/auth/data/models/register_response_model.dart';
import 'package:sahaai/features/auth/data/models/resend_otp_request_model.dart';
import 'package:sahaai/features/auth/data/models/worker_register_response_model.dart';
  import 'package:sahaai/features/auth/domain/repositories/auth_repositories.dart';
  import '../../domain/entities/user_entity.dart';
  import '../../../../core/network/api_service.dart';

  class AuthRepositoryImpl implements AuthRepository {
    final AuthService apiService;

    AuthRepositoryImpl(this.apiService);

    // @override
    // Future<UserEntity> registerUser(RegisterRequestModel model) async {
    //   try {
    //     final response = await apiService.registerUser(model);

    //     return UserEntity(
    //       id: response["userId"] as int,
    //       fullName: response["fullName"],
    //       email: response["email"],
    //       phone: response["phone"],
    //       username: response["username"],
    //     );
    //   } catch (e) {
    //     throw Exception("User Register Failed: $e");
    //   }
    // }
    //   @override
    // Future<RegisterOtpData> registerUser(RegisterRequestModel model) async {
    //   try {
    //     final response = await apiService.registerUser(model);

    //     return response.data;
      
    //   } catch (e) {
    //     throw Exception("User Register Failed: $e");
    //   } 
    // }
    
@override
Future<RegisterOtpData> registerUser(RegisterRequestModel model) async {
  try {
    final fullResponse = await apiService.registerUser(model);    // gets RegisterResponseModel
    if (fullResponse.statusCode == 200) {
      return fullResponse.data;   // Return only the nested RegisterOtpData
    } 
    throw Exception(fullResponse.statusMessage);
  } catch (e) {
    throw Exception("User Register Failed: $e");
  }
}


    @override
    Future<WorkerRegisterOtpData> registerWorker(RegisterRequestModel model) async {
      try {
        final response = await apiService.registerWorker(model);
        return response.data;

        // return UserEntity(
        //   id: response["id"],
        //   fullName: response["fullName"],
        //   email: response["email"],
        //   phone: response["phone"],
        //   username: response["username"],
        // );
      } catch (e) {
        throw Exception("Worker Register Failed: $e");
      }
    }

  
    @override
    Future<UserEntity> loginUser(LoginRequestModel model) async {
      try {
        final response = await apiService.loginUser(model);
    
    final body = response as Map<String, dynamic>; 
    final loginResponse = LoginResponseModel.fromJson(body);
    
    if (loginResponse.statusCode == 200) {
      final userEntity = loginResponse.loginData.toEntity();       
      final token = loginResponse.loginData.token;        // JWT


     await TokenStorage.saveAccessToken(token);
      // TODO: save token with flutter_secure_storage
      // await TokenStorage.saveAccessToken(token);

      return userEntity;
    } else {
      throw Exception(loginResponse.statusMessage);
    }

        // return UserEntity(
        //   id: response["userId"],
        //   fullName: response["fullName"],
        //   email: response["email"],
        //   phone: response["phone"],
        //   username: response["username"],
        // );
      } catch (e) {
        throw Exception("User Login Failed: $e");
      }
    }

    @override
    Future<UserEntity> loginWorker(LoginRequestModel model) async {
      try {
        final response = await apiService.loginWorker(model);

        return UserEntity(
          id: response["id"],
          fullName: response["fullName"],
          email: response["email"],
          phone: response["phone"],
          username: response["username"],
        );
      } catch (e) {
        throw Exception("Worker Login Failed: $e");
      }
    }


    @override
    Future<bool> verifyOtp(OtpVerifyRequestModel model) async {
      try {
        await apiService.verifyOtp(model);
        return true;
      } catch (e) {
        throw Exception("OTP verification failed: $e");
      }
    }
    @override
   Future<bool> resendOtp(ResendOtpRequestModel model) async {
  try {
    await apiService.resendOtp(model);
    return true;
  } catch (e) {
    throw Exception("Resend OTP failed: $e");
  }
  }

    

    @override
    Future<void> logout() async {
    }

    @override
    Future<bool> isLoggedIn() async {
      return false; 
    }
  }
