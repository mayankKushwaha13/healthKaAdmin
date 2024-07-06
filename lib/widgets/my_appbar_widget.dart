import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerType extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.lineTo(0, h - 100);
    path.quadraticBezierTo(w / 2, h + 80, w, h - 100);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.size = 25,
  });
  final String title;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: BannerType(),
          child: Container(
            decoration: const BoxDecoration(
              color: MyColors.Cobalt,
            ),
            height: 150,
            width: double.infinity,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: GoogleFonts.aBeeZee(
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
            transform: Matrix4.translationValues(
                -MediaQuery.of(context).size.width / 2 + 35, -45, 0),
            child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: MyColors.Peach,
            size: 30,
          ),
        )),
      ],
    );
  }
}
