class OtpVerifyRequestModel {
  final int id;
  final String otp;

  OtpVerifyRequestModel({
    required this.id,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "otp": otp,
      };
}
