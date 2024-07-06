import 'package:admin/widgets/textFieldWidgets/my_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.controller, required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Text("$title :",
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          ),
          Expanded(
            child: MyTextField(
              controller: controller,
              bold: true,
            ),
          ),
        ],
      ),
    );
  }
}
