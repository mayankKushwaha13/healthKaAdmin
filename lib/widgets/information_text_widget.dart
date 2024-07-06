import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationTextWidget extends StatefulWidget {
  final String text1;
  final String text2;
  const InformationTextWidget({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  State<InformationTextWidget> createState() => _InformationTextWidgetState();
}

class _InformationTextWidgetState extends State<InformationTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.text1} : ",
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.text2.toString(),
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
