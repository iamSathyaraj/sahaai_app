// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:sahaai/core/enums/role.dart';
// import 'package:sahaai/features/auth/presentation/pages/login_page.dart';
// import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
// import 'package:sahaai/features/auth/presentation/widgets/rounded_textfield.dart';
// import 'package:sahaai/features/auth/presentation/widgets/socialbutton.dart';

//   class RegisterPage extends StatelessWidget {

//     const RegisterPage({super.key});  
//     @override
//     Widget build(BuildContext context) {
//       final mainColor = Color(0xFF466765);
//       final gradient = LinearGradient(
//         colors: [mainColor, Color(0xFF263a39)],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       );
//       final registerProvider = context.watch<RegisterProvider>();
//          return 
//          Scaffold(
//           body: Container(
//             decoration: BoxDecoration(gradient: gradient),
//             width: double.infinity,
//             height: double.infinity,
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//                   padding: EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26, 
//                         blurRadius: 16,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Create Account',
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                           color: mainColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 30),
//                         RoundedTextField(
//                         controller:   registerProvider.fullNameController,
//                         hintText: 'fullName',
//                         icon: Icons.person_outline,
//                         errorText: registerProvider.usernameError,
//                         obscureText: false,
//                       ),
//                        SizedBox(height: 16),
      
//                       RoundedTextField(
//                         controller:   registerProvider.usernameController,
//                         hintText: 'Username',
//                         icon: Icons.person_outline,
//                         errorText: registerProvider.usernameError,
//                         obscureText: false,
//                       ),
//                       SizedBox(height: 16),
//                       RoundedTextField(
//                         controller: registerProvider.emailController,
//                         hintText: 'Email',
//                         icon: Icons.email_outlined,
//                         obscureText: false,
//                         errorText: registerProvider.emailError,
//                       ),
//                       SizedBox(height: 16),
//                       RoundedTextField(
//                         controller: registerProvider.phoneController,
//                         hintText: 'Phone',
//                         icon: Icons.phone_outlined,
//                         obscureText: false,
//                         errorText: registerProvider.phoneError,
//                       ),
//                       SizedBox(height: 16),
//                       RoundedTextField(
//                         controller: registerProvider.passwordController,
//                         hintText: 'Password',
//                         icon: Icons.lock_outline,
//                         obscureText: true,
//                         errorText: registerProvider.passwordError,
                
//                       ),
//                       SizedBox(height: 16),
//                       RoundedTextField(
//                         controller: registerProvider.confirmPasswordController,
//                         hintText: 'Confirm Password',
//                         icon: Icons.lock_outline,
//                         obscureText: true,
//                         errorText: registerProvider.confirmPasswordError,
//                       ),
//                       SizedBox(height: 32),
//                       SizedBox(
//                         height: 52,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: mainColor,
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           shadowColor: mainColor,
//                         ),
//                         onPressed: registerProvider.isLoading
//                             ? null
//                             : () async {
//                                 final success =
//                                     await registerProvider.submitRegister(UserRole.customer);
//                           if (success && registerProvider.registeredUserId != null) {
//                                            context.go('/otp-verify/${registerProvider.registeredUserId}');
//                              }else {
//                              ScaffoldMessenger.of(context).showSnackBar(
//                              SnackBar(content: Text('Registration failed.: ${registerProvider.generalErrorMessage ?? "unknown error"}.')),
//                             );
//                             }
//                               }, 
//                         child: registerProvider.isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                                 'Register',
//                                  style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: Colors.white,
//                                  ),
//                                ),
//                              ),
//                            ),  
//                       SizedBox(height: 24),
//                       Center(
//                         child: Text(
//                           'Or sign up with',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                       ),
//                       SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SocialButton(
//                             icon: Icons.g_mobiledata,
//                             background: Colors.white,
//                             iconColor: Colors.blue,
//                             onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//                             },
//                           ),
//                           SizedBox(width: 18),
//                           SocialButton(
//                             icon: Icons.apple,
//                             background: Colors.black,
//                             iconColor: Colors.white,
//                             onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//                             },   
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 28),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Already have an account? ",
//                             style: TextStyle(color: Colors.grey[800]),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.push(context,
//                              MaterialPageRoute(builder: (context)=>LoginPage())),
//                             child: Text("SignUp",
//                               style: TextStyle(
//                                 color: mainColor,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//     }
//   }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/core/enums/role.dart';
import 'package:sahaai/features/auth/presentation/provider/register_provider.dart';
import 'package:sahaai/features/auth/presentation/widgets/rounded_textfield.dart';
import 'package:sahaai/features/auth/presentation/widgets/socialbutton.dart';
import 'package:sahaai/features/auth/presentation/pages/login_page.dart';

class WorkerRegisterPage extends StatelessWidget {
  const WorkerRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor = const Color(0xFF466765);
    final gradient = LinearGradient(
      colors: [mainColor, const Color(0xFF263a39)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final registerProvider = context.watch<RegisterProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
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
                    'Worker Sign Up',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: mainColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your worker account to receive jobs',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Full name
                  RoundedTextField(
                    controller: registerProvider.fullNameController,
                    hintText: 'Full Name',
                    icon: Icons.person_outline,
                    errorText: registerProvider.fullNameError,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),

                  RoundedTextField(
                    controller: registerProvider.usernameController,
                    hintText: 'Username',
                    icon: Icons.person_outline,
                    errorText: registerProvider.usernameError,
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),

                  RoundedTextField(
                    controller: registerProvider.emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    obscureText: false,
                    errorText: registerProvider.emailError,
                  ),
                  const SizedBox(height: 16),

                  RoundedTextField(
                    controller: registerProvider.phoneController,
                    hintText: 'Phone',
                    icon: Icons.phone_outlined,
                    obscureText: false,
                    errorText: registerProvider.phoneError,
                  ),
                  const SizedBox(height: 16),

                  RoundedTextField(
                    controller: registerProvider.passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    errorText: registerProvider.passwordError,
                  ),
                  const SizedBox(height: 16),

                  RoundedTextField(
                    controller: registerProvider.confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    errorText: registerProvider.confirmPasswordError,
                  ),
                  const SizedBox(height: 24),

                  if (registerProvider.generalErrorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        registerProvider.generalErrorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),

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
                      onPressed: registerProvider.isLoading
                          ? null
                          : () async {
                              final success = await registerProvider
                                  .submitRegister(UserRole.worker);
                              if (success &&
                                  registerProvider.registeredUserId != null) {
                                context.go(
                                  '/otp-verify/${registerProvider.registeredUserId}',
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Worker registration failed: ${registerProvider.generalErrorMessage ?? "unknown error"}.',
                                    ),
                                  ),
                                );
                              }
                            },
                      child: registerProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Register as Worker',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Or sign up with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        icon: Icons.g_mobiledata,
                        background: Colors.white,
                        iconColor: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 18),
                      SocialButton(
                        icon: Icons.apple,
                        background: Colors.black,
                        iconColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have a worker account? ",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextButton(
                        onPressed: () {
                          // navigate to worker login page
                          context.go('/worker-login');
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
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

  