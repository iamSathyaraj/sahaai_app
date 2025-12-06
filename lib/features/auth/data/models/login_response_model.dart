import 'package:sahaai/features/auth/domain/entities/user_entity.dart';

class LoginResponseModel {
final int statusCode;
final String statusMessage;

final LoginDataModel loginData;

LoginResponseModel({
  required this.statusCode,
  required this.statusMessage,
  required this.loginData

});

factory LoginResponseModel.fromJson(Map <String, dynamic>json){
  return LoginResponseModel(
    statusCode: json["statusCode"],
     statusMessage: json["statusMessage"],
      loginData: LoginDataModel.fromJson(json["data"] as Map<String, dynamic>)
      );
}
 UserEntity toEntity() => loginData.toEntity();

}
class LoginDataModel {

  final int userId;
  final String userName;
  final String email;
  final String role;
  final String token;

  LoginDataModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.role,
    required this.token
  });

factory LoginDataModel.fromJson(Map<String, dynamic>json){
  return LoginDataModel(
    userId: json["userId"] as int,
     userName: json["userName"] as String,
      email: json["email"] as String,
       role: json["role"] as String,
        token: json["token"] as String
        );
}


  UserEntity toEntity() => UserEntity(
    id: userId,
     fullName: userName,
      username: userName,
       email: email,
        phone: "");

}