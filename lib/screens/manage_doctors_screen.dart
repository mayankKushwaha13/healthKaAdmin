import 'package:admin/constants/colors.dart';
import 'package:admin/constants/weekdays.dart';
import 'package:admin/data/doctors_database.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/models/doctor.dart';
import 'package:admin/screens/add_doctor_screen.dart';
import 'package:admin/widgets/drawer_widget.dart';
import 'package:admin/widgets/editBoxes/edit_box_doctor_widget.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageDoctorsScreen extends StatefulWidget {
  const ManageDoctorsScreen({super.key});

  @override
  State<ManageDoctorsScreen> createState() => _ManageDoctorsScreenState();
}

class _ManageDoctorsScreenState extends State<ManageDoctorsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController stimeController = TextEditingController();
  final TextEditingController etimeController = TextEditingController();
  ScrollPhysics physics = const AlwaysScrollableScrollPhysics();
  List<String> docDays = [];
  bool isVisible = false;
  String? docID;
  String? gender;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: DoctorsDB().readData(),
            builder: (context, snapshot) {
              List<Doctor> doctorList = [];
              if (snapshot.hasData) {
                doctorList = snapshot.data!
                    .where((e) => e.adminID == SP.sp!.getInt(SP.adminIDKEY) && e.status == 'Accepted')
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
                            const MyAppBar(title: "Doctor List"),
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
                                            setState(() {
                                              for (var map in weekdays) {
                                                map['isChecked'] = false;
                                              }
                                            });
                                            Get.to(() => const AddDoctorScreen(),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 7),
                                            child: Text(
                                              "Add Doctor",
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
                                      itemCount: doctorList.length,
                                      itemBuilder: (context, index) {
                                        Doctor doctor = doctorList[index];
                                        List<String> days =
                                            doctor.days.split(", ");
                                        return Card(
                                          elevation: 2,
                                          color: Colors.red.shade100,
                                          child: ListTile(
                                            leading: Image.asset(
                                              doctor.image,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doctor.name,
                                                  style: GoogleFonts.lato(
                                                      color:
                                                          MyColors.DarkSienna,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Wrap(
                                                  children: [
                                                    Text(
                                                      "ID : ",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      doctor.docID,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Phone : ",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      doctor.phone,
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
                                                  "Working Days : ",
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.bold,
                                                    color: MyColors.Navy,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Row(),
                                                for (int i = 0;
                                                    i < days.length;
                                                    i++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 3, top: 3),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          MyColors.Rosewood,
                                                      child: Text(
                                                        days[i],
                                                        style: GoogleFonts.lato(
                                                            color:
                                                                MyColors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                            trailing: SpeedDial(
                                              animatedIcon:
                                                  AnimatedIcons.menu_close,
                                              foregroundColor: MyColors.Gold,
                                              backgroundColor: MyColors.Navy,
                                              direction:
                                                  SpeedDialDirection.left,
                                              overlayColor: MyColors.Navy2,
                                              overlayOpacity: 0.25,
                                              children: [
                                                SpeedDialChild(
                                                    onTap: () {
                                                      setState(() {
                                                        docDays = doctor.days
                                                            .split(", ");
                                                        print(docDays);
                                                        docID = doctor.docID;
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
                                                      DoctorsDB().deleteData(
                                                          doctor.docID);
                                                      setState(() {
                                                      });
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
                        EditBoxDoctorWidget(
                          days: docDays,
                          visibility: isVisible,
                          nameController: nameController,
                          phoneController: phoneController,
                          clinicNameController: clinicNameController,
                          daysController: daysController,
                          stimeController: stimeController,
                          etimeController: etimeController,
                          onBack: () {
                            nameController.clear();
                            clinicNameController.clear();
                            phoneController.clear();
                            daysController.clear();
                            stimeController.clear();
                            etimeController.clear();
                            for (var map in weekdays) {
                              setState(() {
                                map['isChecked'] = false;
                              });
                              map['isChecked'] = false;
                            }
                            setState(() {
                              isVisible = false;
                              physics = const AlwaysScrollableScrollPhysics();
                            });
                          },
                          onTap: () async {
                            if (nameController.text.isNotEmpty) {
                              await DoctorsDB().updateData(
                                  docID!, {'name': nameController.text});
                            }
                            if (phoneController.text.isNotEmpty) {
                              await DoctorsDB().updateData(
                                  docID!, {'phone': phoneController.text});
                            }
                            if (clinicNameController.text.isNotEmpty) {
                              await DoctorsDB().updateData(
                                  docID!, {'clinicName': nameController.text});
                            }
                            for (var element in weekdays) {
                              if (element['isChecked'] &&
                                  !docDays.contains(
                                      element['day'].substring(0, 3))) {
                                docDays.add(element['day'].substring(0, 3));
                                setState(() {
                                  element['isChecked'] = false;
                                });
                              } else if (!element['isChecked'] &&
                                  docDays.contains(
                                      element['day'].substring(0, 3))) {
                                docDays.removeWhere(
                                    (e) => e == element['day'].substring(0, 3));
                              }
                            }
                            daysController.text = docDays.join(", ");
                            await DoctorsDB().updateData(docID!, {'days' : daysController.text});
                            if (stimeController.text.isNotEmpty) {
                              await DoctorsDB().updateData(
                                  docID!, {'stime': stimeController.text});
                            }
                            if (etimeController.text.isNotEmpty) {
                              await DoctorsDB().updateData(
                                  docID!, {'etime': etimeController.text});
                            }
                            nameController.clear();
                            clinicNameController.clear();
                            phoneController.clear();
                            daysController.clear();
                            stimeController.clear();
                            etimeController.clear();
                            for (var map in weekdays) {
                              setState(() {
                                map['isChecked'] = false;
                              });
                            }
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
