import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    this.obscure = false,
    this.hint = "",
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.bold = false,
  });

  final TextEditingController controller;
  final bool obscure;
  final String hint;
  final Color color;
  final Color textColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        style: GoogleFonts.lato(
          color: textColor,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: GoogleFonts.lato(
            color: textColor,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87),
          ),
          fillColor: color,
          filled: true,
        ),
      ),
    );
  }
}
