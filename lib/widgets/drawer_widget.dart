import 'package:admin/constants/colors.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.Navy,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 80, right: 20, left: 20, bottom: 40),
              child: Image.asset("lib/assets/healthka.png"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: MyColors.LightPink,
            leading: const Icon(
              Icons.home,
              color: MyColors.Burgundy,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  color: MyColors.Burgundy,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
               Scaffold.of(context).closeDrawer();
               Navigator.of(context).popUntil(ModalRoute.withName('/HomeScreen'));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: MyColors.LightPink,
            leading: const Icon(
              Icons.person,
              color: MyColors.Burgundy,
            ),
            title: Text('Admin',
                style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    color: MyColors.Burgundy,
                    fontWeight: FontWeight.bold)),
            onTap: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(context).pushNamed('/AdminProfile');
              Future.delayed(const Duration(milliseconds: 30), (){
                if (Get.previousRoute == '/AdminProfile'){
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).pop();
              }
              });
              
            },
          ),
          const Expanded(child: SizedBox()),
          ListTile(
            tileColor: MyColors.LightPink,
            leading: const Icon(
              Icons.logout_rounded,
              color: MyColors.Burgundy,
            ),
            title: Text(
              "Logout",
              style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.DarkSienna),
            ),
            onTap: () async {
              SP.sp!.setBool(SP.login, false);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
          )
        ],
      ),
    );
  }
}
