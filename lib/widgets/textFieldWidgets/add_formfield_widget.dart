import 'package:admin/widgets/textFieldWidgets/my_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFormFieldWidget extends StatelessWidget {
  const AddFormFieldWidget({
    super.key,
    required this.controller,
    required this.title,
    this.obscure = false,
    this.onEyeTap,
    this.icon,
    this.password = false,
    this.numbersOnly = false,
  });

  final TextEditingController controller;
  final String title;
  final bool obscure;
  final void Function()? onEyeTap;
  final IconData? icon;
  final bool password;
  final bool numbersOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            title,
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: MyTextFormField(
          controller: controller,
          password: password,
          obscure: obscure,
          onEyeTap: onEyeTap,
          icon: icon,
          numbersOnly: numbersOnly,
        )),
      ],
    );
  }
}
