
class RegisterResponseModel {
  final int statusCode;
  final String statusMessage;
  final RegisterOtpData data;

  RegisterResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      statusCode: json['statusCode'] as int,
      statusMessage: json['statusMessage'] as String,
      data: RegisterOtpData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class RegisterOtpData {
  final int userId;

  RegisterOtpData({
    required this.userId,
  });

  factory RegisterOtpData.fromJson(Map<String, dynamic> json) {
    return RegisterOtpData(
      userId: json['userId'] as int,
    );
  }
}
