import 'package:admin/constants/colors.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:admin/widgets/circular_design_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Stack(
          alignment: Alignment.center,
          children: [
            CircularDesign(radius: 400, opacity: 0.3, x: -width/2, y: -height/2, color: MyColors.Cobalt,),
                CircularDesign(radius: 360, opacity: 0.3, x: width/2, y: height/2, color: MyColors.Cobalt,),
                CircularDesign(radius: 200, opacity: 0.25, y: height/2,color: MyColors.Cobalt,),
                CircularDesign(radius: 200, opacity: 0.25, y: -height/2, color: MyColors.Cobalt,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset('lib/assets/healthka.png',width: 260,),
                    Text("Admin   ", style: GoogleFonts.aBeeZee(color: MyColors.DarkSienna, fontWeight: FontWeight.bold),)
                  ],
                ),
                Image.asset('lib/assets/loading.gif', height: 60, color: MyColors.RedDark,),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void checkLogin()async{
    var isLoggedIn = SP.sp!.getBool(SP.login);

    Timer(const Duration(milliseconds: 3550), () {
      if(isLoggedIn != null){
        if(isLoggedIn){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen()));
        }
        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen()));
        }
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen()));
      }
    });
  }
}