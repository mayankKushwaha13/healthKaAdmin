import 'package:admin/constants/colors.dart';
import 'package:admin/data/receptionist_database.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/functions/age_calculator.dart';
import 'package:admin/functions/string_to_dob.dart';
import 'package:admin/models/receptionist.dart';
import 'package:admin/screens/add_receptionist_screen.dart';
import 'package:admin/widgets/drawer_widget.dart';
import 'package:admin/widgets/editBoxes/edit_box_widget.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageReceptionistsScreen extends StatefulWidget {
  const ManageReceptionistsScreen({super.key});

  @override
  State<ManageReceptionistsScreen> createState() =>
      _ManageReceptionistsScreenState();
}

class _ManageReceptionistsScreenState extends State<ManageReceptionistsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  ScrollPhysics physics = const AlwaysScrollableScrollPhysics();
  bool isVisible = false;
  String? recID;
  String? gender;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: ReceptionistDB().readData(),
            builder: (context, snapshot) {
              List<Receptionist> receptionistList = [];
              if (snapshot.hasData) {
                receptionistList = snapshot.data!
                    .where((e) => e.adminID == SP.sp!.getInt(SP.adminIDKEY))
                    .toList();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: physics,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            const MyAppBar(title: "Receptionist List"),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Ink(
                                        decoration: BoxDecoration(
                                            color: MyColors.DarkSienna,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            Get.to(
                                                () => const AddReceptionistScreen(),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 7),
                                            child: Text(
                                              "Add Recpetionist",
                                              style: GoogleFonts.aBeeZee(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors.Peach),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: receptionistList.length,
                                      itemBuilder: (context, index) {
                                        Receptionist receptionist =
                                            receptionistList[index];
                                        return Card(
                                          elevation: 2,
                                          color: Colors.amber.shade50,
                                          child: ListTile(
                                            leading: Image.asset(
                                              receptionist.image,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  receptionist.name,
                                                  style: GoogleFonts.lato(
                                                      color: MyColors.DarkSienna,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "ID : ",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      receptionist.recID,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            dense: true,
                                            isThreeLine: true,
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            subtitle: Wrap(
                                              children: [
                                                Text(
                                                  getAge(parseDOB(
                                                          receptionist.dob))
                                                      .toString(),
                                                  style: GoogleFonts.lato(
                                                      color: MyColors.Navy,
                                                      fontSize: 16),
                                                ),
                                                const VerticalDivider(),
                                                Text(
                                                  receptionist.gender,
                                                  style: GoogleFonts.lato(
                                                    color: MyColors.Navy,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const VerticalDivider(),
                                                Text(
                                                  receptionist.phone,
                                                  style: GoogleFonts.lato(
                                                    color: MyColors.Navy,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: SpeedDial(
                                              animatedIcon:
                                                  AnimatedIcons.menu_close,
                                              foregroundColor: MyColors.Gold,
                                              backgroundColor: MyColors.Navy,
                                              direction: SpeedDialDirection.left,
                                              overlayColor: MyColors.Navy2,
                                              overlayOpacity: 0.25,
                                              children: [
                                                SpeedDialChild(
                                                    onTap: () {
                                                      setState(() {
                                                        recID =
                                                            receptionist.recID;
                                                        gender =
                                                            receptionist.gender;
                                                        isVisible = true;
                                                        physics =
                                                            const NeverScrollableScrollPhysics();
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: MyColors.Indigo,
                                                    ),
                                                    label: "Edit"),
                                                SpeedDialChild(
                                                    onTap: () {
                                                      ReceptionistDB().deleteData(
                                                          receptionist.recID);
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons.delete,
                                                      color: MyColors.RedDark,
                                                    ),
                                                    label: "Delete"),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        EditBoxWidget(
                          visibility: isVisible,
                          gender: gender ?? "Male",
                          nameController: nameController,
                          genderController: genderController,
                          phoneController: phoneController,
                          dobController: dobController,
                          onBack: () {
                            nameController.clear();
                            phoneController.clear();
                            dobController.clear();
                            genderController.clear();
                            setState(() {
                              isVisible = false;
                              physics = const AlwaysScrollableScrollPhysics();
                            });
                          },
                          onTap: () async {
                            if (nameController.text.isNotEmpty) {
                              await ReceptionistDB().updateData(
                                  recID!, {'name': nameController.text});
                            }
                            if (phoneController.text.isNotEmpty) {
                              await ReceptionistDB().updateData(
                                  recID!, {'phone': phoneController.text});
                            }
                            if (dobController.text.isNotEmpty) {
                              await ReceptionistDB().updateData(
                                  recID!, {'dob': dobController.text});
                            }
                            if (genderController.text.isNotEmpty) {
                              await ReceptionistDB().updateData(
                                  recID!, {'gender': genderController.text});
                            }
                            nameController.clear();
                            phoneController.clear();
                            dobController.clear();
                            genderController.clear();
                            setState(() {
                              isVisible = false;
                              physics = const AlwaysScrollableScrollPhysics();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
