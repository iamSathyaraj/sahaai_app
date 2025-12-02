import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sahaai/features/auth/presentation/provider/otp_provider.dart';

class OtpVerificationPage extends StatelessWidget {
  final int userId; 
 
OtpVerificationPage({
  required this.userId,
 });

  @override
  Widget build(BuildContext context) {
        final verifyOtpUseCase = context.read<VerifyOtpUseCase>();

    final mainColor = Color(0xFF466765);

    return ChangeNotifierProvider<OtpProvider>(
      create: (_) => OtpProvider(verifyOtpUseCase),
      child: Consumer<OtpProvider>(
        builder: (context, otpProvider, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(color: Colors.black87),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "OTP Verification",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter the 6-digit  verification code sent to your email.",
                      style:
                          TextStyle(color: Colors.grey[700], fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                           margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 48,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: mainColor, width: 2),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: otpProvider.otpControllers[index], 
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            onChanged: (val) {
                              if (val.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                              if (val.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: otpProvider.isLoading
                            ? null
                            : () async {

                                bool success = await otpProvider.submitOtp(
                                    userId);

                                if (success) {
                                 context.go("/home");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          otpProvider.errorMessage ?? 'Verification failed'),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: otpProvider.isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Verify',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text: "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Resend Code",
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

