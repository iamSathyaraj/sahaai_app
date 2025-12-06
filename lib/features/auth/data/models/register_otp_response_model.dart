class RegisterOtpResponseModel {
  final int statusCode;
  final String statusMessage;
  final RegisterOtpData data;

  RegisterOtpResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory RegisterOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterOtpResponseModel(
      statusCode: json['statusCode'] as int,
      statusMessage: json['statusMessage'] as String,
      data: RegisterOtpData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class RegisterOtpData {
  final int userId;

  RegisterOtpData({required this.userId});

  factory RegisterOtpData.fromJson(Map<String, dynamic> json) {
    return RegisterOtpData(userId: json['userId'] as int);
  }
}
