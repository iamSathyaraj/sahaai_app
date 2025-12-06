class WorkerRegisterResponseModel {
  final int statusCode;
  final String statusMessage;
  final WorkerRegisterOtpData data;

  WorkerRegisterResponseModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory WorkerRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return WorkerRegisterResponseModel(
      statusCode: json['statusCode'] as int,
      statusMessage: json['statusMessage'] as String,
      data: WorkerRegisterOtpData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class WorkerRegisterOtpData {
  final int userId;
  final String otp; 

  WorkerRegisterOtpData({
    required this.userId,
    required this.otp,
  });

  factory WorkerRegisterOtpData.fromJson(Map<String, dynamic> json) {
    return WorkerRegisterOtpData(
      userId: json['userId'] as int,
      otp: json['otp'] as String,
    );
  }
}
