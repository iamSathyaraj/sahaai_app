import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
    final String? errorText;




  const RoundedTextField({
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.controller,
    this.validator,
    this.errorText,


  }); 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF466765)),
        hintText: hintText,
        errorText: errorText,
        filled: true,
        fillColor: const Color.fromARGB(245, 245, 245, 245),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),  
        border: OutlineInputBorder(  
          
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

