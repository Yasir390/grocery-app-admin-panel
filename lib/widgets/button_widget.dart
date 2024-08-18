import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.buttonText, required this.iconName,
    required this.onPressed,
     this.backgroundColor=Colors.blueAccent });

  final String buttonText;
  final IconData iconName;
  final VoidCallback onPressed;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed:onPressed,
      icon: Icon(iconName),
      label: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor:backgroundColor ,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }
}
