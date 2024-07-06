import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtonWidget extends StatefulWidget {
  const MyButtonWidget({
    super.key, 
    required this.button,
    required this.onTap,
  });
  final Map button;
  final void Function() onTap;

  @override
  State<MyButtonWidget> createState() => _MyButtonWidgetState();
}

class _MyButtonWidgetState extends State<MyButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: widget.button['selected'] ? MyColors.Cobalt: Colors.transparent,
          border: Border.all(color: MyColors.Cobalt, width: 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(1000),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child: Text(
              widget.button['name'],
              style: GoogleFonts.josefinSans(
                color: widget.button['selected']? Colors.white : MyColors.DarkSienna,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}