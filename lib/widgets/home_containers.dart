import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContainers extends StatelessWidget {
  final String title;
  final String image;
  final Color color1;
  final Color color2;
  final Widget page;
  const HomeContainers({
    super.key,
    required this.title,
    required this.image,
    this.color1 = MyColors.Burgundy,
    this.color2 = MyColors.DarkSienna,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Ink(
          height: 200,
          width: 160,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color1,
                  color2,
                ],
                stops: const [0.2, 0.5],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              Get.to(()=>page, transition: Transition.rightToLeft);
            },
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
