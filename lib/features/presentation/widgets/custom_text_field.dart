import 'package:flutter/material.dart';
import 'package:ostello/core/services/theme_service.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: ThemeService.labelMedium.copyWith(
        color: const Color(0xFF7C7C7C), // #7C7C7C color for hint text
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ThemeService.labelMedium.copyWith(
          color: const Color(0xFF7C7C7C), // #7C7C7C color for hint text
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color:
                ThemeService.secondaryColor.withOpacity(0.2), // Underline color
            width: 1.0, // Thickness of the underline
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ThemeService.secondaryColor
                .withOpacity(0.2), // Underline color when focused
            width: 1.0, // Thickness of the underline
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none, // No border for the text field
        ),
        filled: true,
        fillColor: Colors.white, // Background color of the text field
      ),
    );
  }
}
