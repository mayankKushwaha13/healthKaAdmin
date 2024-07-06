import 'package:admin/constants/colors.dart';
import 'package:admin/data/admin_database.dart';
import 'package:admin/data/admin_list.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/widgets/circular_design_widget.dart';
import 'package:admin/widgets/textFieldWidgets/my_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularDesign(
                radius: 400,
                opacity: 0.3,
                x: -width / 2,
                y: -height / 2,
                color: MyColors.Cobalt,
              ),
              CircularDesign(
                radius: 360,
                opacity: 0.3,
                x: width / 2,
                y: height / 2,
                color: MyColors.Cobalt,
              ),
              CircularDesign(
                radius: 200,
                opacity: 0.25,
                y: height / 2,
                color: MyColors.Cobalt,
              ),
              CircularDesign(
                radius: 200,
                opacity: 0.25,
                y: -height / 2,
                color: MyColors.Cobalt,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Image(
                        image: AssetImage("lib/assets/healthka.png"),
                        height: 80,
                      ),
                      Text(
                        "Admin   ",
                        style: GoogleFonts.aBeeZee(
                            color: MyColors.DarkSienna,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    child: Text(
                      "Aap ke health ke liye healthka :)",
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: username,
                    hint: "Enter Username",
                    bold: true,
                    color: MyColors.Burgundy,
                    textColor: MyColors.Gold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: password,
                    hint: "Enter Password",
                    bold: true,
                    color: MyColors.Burgundy,
                    textColor: MyColors.Gold,
                    obscure: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Ink(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.Navy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () async {
                          var userFound = userList.indexWhere((admin) =>
                              admin.adminID.toString() ==
                              username.text.toString());

                          if (userFound != -1) {
                            if (adminList[userFound]['password'].toString() ==
                                password.text.toString()) {
                              SP.sp!.setBool(SP.login, true);
                              SP.sp!.setInt(
                                  SP.adminIDKEY, userList[userFound].adminID);
                              // SP.sp!.setInt(SP.adminIDKEY, userFound);

                              List getList = await AdminDatabase().readData();
                              var user = getList.where((admin) =>
                                  admin.adminID == userList[userFound].adminID);
                              if (user.isEmpty) {
                                AdminDatabase().insertData(userList[userFound]);
                              }

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
                              username.clear();
                              password.clear();
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Incorrect Password"),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid ID"),
                            ));
                          }
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Login",
                              style: GoogleFonts.lato(
                                color: MyColors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
