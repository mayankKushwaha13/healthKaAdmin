import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    this.obscure = false,
    this.onEyeTap,
    this.icon,
    this.password = false,
    this.numbersOnly = false,
  });

  final TextEditingController controller;
  final bool obscure;
  final void Function()? onEyeTap;
  final IconData? icon;
  final bool password;
  final bool numbersOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Necessary Field";
          }
          return null;
        },
        keyboardType: numbersOnly?TextInputType.number: null,
        inputFormatters: numbersOnly?[FilteringTextInputFormatter.digitsOnly]:null,
        style: GoogleFonts.lato(fontSize: 18, color: MyColors.Peach),
        decoration: InputDecoration(
          fillColor: MyColors.Navy,
          filled: true,
          suffixIcon: password ? IconButton(
            onPressed: password ? onEyeTap:(){} ,
            icon: Icon(icon, color: Colors.white,)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}
