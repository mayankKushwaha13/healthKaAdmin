import 'package:admin/constants/colors.dart';
import 'package:admin/screens/doctor_status_screen.dart';
import 'package:admin/screens/manage_doctors_screen.dart';
import 'package:admin/screens/manage_receptionists_screen.dart';
import 'package:admin/widgets/drawer_widget.dart';
import 'package:admin/widgets/home_containers.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyAppBar(title: "Home"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome, Admin",
                style: GoogleFonts.josefinSans(
                    color: MyColors.DarkSienna,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Card(
                elevation: 5,
                color: MyColors.FadedBlue,
                margin: EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeContainers(
                      page: ManageReceptionistsScreen(),
                      title: "Manage\nReceptionists",
                      image: "lib/assets/receptionist.png",
                    ),
                    HomeContainers(
                      page: ManageDoctorsScreen(),
                      title: "Manage\nDoctors",
                      image: "lib/assets/doctor.png",
                      color1: MyColors.Cobalt,
                      color2: MyColors.Navy,
                    )
                  ],
                ),
              ),
              const Card(
                elevation: 5,
                color: MyColors.FadedBlue,
                margin: EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeContainers(
                      page: DoctorStatusScreen(),
                      title: "Doctor Request\nStatus",
                      image: "lib/assets/status.png",
                      color1: MyColors.RedDark,
                      color2: MyColors.Burgundy,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
