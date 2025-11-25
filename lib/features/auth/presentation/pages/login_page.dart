import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/auth/presentation/pages/register_page.dart';
import 'package:sahaai/features/auth/presentation/provider/login_provider.dart';
import 'package:sahaai/features/auth/presentation/widgets/rounded_textfield.dart';
import 'package:sahaai/features/auth/presentation/widgets/socialbutton.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainColor = Color(0xFF466765);
    final gradient = LinearGradient(
      colors: [mainColor, Color(0xFF263a39)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 14,
                    offset: Offset(2, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: mainColor,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  RoundedTextField(
                    controller: loginProvider.emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    obscureText: false,
                    errorText: loginProvider.emailError,
                  ),
                  SizedBox(height: 18),

                  RoundedTextField(
                    controller: loginProvider.passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    errorText: loginProvider.passwordError,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  if (loginProvider.generalErrorMessage != null) ...[
                    SizedBox(height: 8),
                    Text(
                      loginProvider.generalErrorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],

                  SizedBox(height: 16),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        elevation: 7,
                        shadowColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: (){
                        loginProvider.validate();
                      },
                      child: loginProvider.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 28),
                  Center(
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        icon: Icons.g_mobiledata,
                        background: Colors.white,
                        iconColor: Colors.blue,
                        onPressed: () {
                        },
                      ),
                      SizedBox(width: 20),
                      SocialButton(
                        icon: Icons.apple,
                        background: Colors.black,
                        iconColor: Colors.white,
                        onPressed: () {
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
