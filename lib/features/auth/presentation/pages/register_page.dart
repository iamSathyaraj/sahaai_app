  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
import 'package:sahaai/features/auth/presentation/pages/login_page.dart';
  import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
  import 'package:sahaai/features/auth/presentation/widgets/rounded_textfield.dart';
  import 'package:sahaai/features/auth/presentation/widgets/socialbutton.dart';

  class RegisterPage extends StatelessWidget {


    RegisterPage(

    );
    @override
    Widget build(BuildContext context) {
      final mainColor = Color(0xFF466765);
      final gradient = LinearGradient(
        colors: [mainColor, Color(0xFF263a39)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
          final registerProvider = context.watch<RegisterProvider>();


      return 
        Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: gradient),
            width: double.infinity,
            height: double.infinity,
            child: Center( 
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, 
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                        RoundedTextField(
                        controller:   registerProvider.fullNameController,
                        hintText: 'fullName',
                        icon: Icons.person_outline,
                        errorText: registerProvider.fullNameError ,
                        obscureText: false,
                      ),
                       SizedBox(height: 16),
      
                      RoundedTextField(
                        controller:   registerProvider.usernameController,
                        hintText: 'Username',
                        icon: Icons.person_outline,
                        errorText: registerProvider.usernameError,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      RoundedTextField(
                        controller: registerProvider.emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        obscureText: false,
                        errorText: registerProvider.emailError,
                      ),
                      SizedBox(height: 16),
                      RoundedTextField(
                        controller: registerProvider.phoneController,
                        hintText: 'Phone',
                        icon: Icons.phone_outlined,
                        obscureText: false,
                        errorText: registerProvider.phoneError,
                      ),
                      SizedBox(height: 16),
                      RoundedTextField(
                        controller: registerProvider.passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        errorText: registerProvider.passwordError,
                
                      ),
                      SizedBox(height: 16),
                      RoundedTextField(
                        controller: registerProvider.confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        errorText: registerProvider.confirmPasswordError,
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        height: 52,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadowColor: mainColor,
                        ),
                       onPressed: (){
                        registerProvider.validate();
                       },
                       child: Text("Register"),
                      ),
                      ), 
                      SizedBox(height: 24),
                      Center(
                        child: Text(
                          'Or sign up with',
                          style: TextStyle(color: Colors.grey[700]),
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
                          SizedBox(width: 18),
                          SocialButton(
                            icon: Icons.apple,
                            background: Colors.black,
                            iconColor: Colors.white,
                            onPressed: () {
                            },   
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(context,
                             MaterialPageRoute(builder: (context)=>LoginPage())),
                            child: Text("Sign In",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
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

