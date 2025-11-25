import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final VoidCallback onPressed;

  const SocialButton({
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        backgroundColor: background,
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      ),
      onPressed: onPressed,
      child: Icon(icon, color: iconColor, size: 28),
    );
  }
}
