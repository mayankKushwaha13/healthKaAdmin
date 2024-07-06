import 'package:admin/constants/buttons.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/data/doctors_database.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/models/doctor.dart';
import 'package:admin/widgets/drawer_widget.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:admin/widgets/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorStatusScreen extends StatefulWidget {
  const DoctorStatusScreen({super.key});

  @override
  State<DoctorStatusScreen> createState() => _DoctorStatusScreenState();
}

class _DoctorStatusScreenState extends State<DoctorStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: DoctorsDB().readData(),
            builder: (context, snapshot) {
              var selected = buttons
                  .where((element) => element['selected'] == true)
                  .toList();
              var status = selected.first['name'];
              List<Doctor> docList = [];
              if (snapshot.hasData) {
                if (status != 'All') {
                  docList = snapshot.data!
                      .where((element) =>
                          element.status == status &&
                          element.adminID == SP.sp!.getInt(SP.adminIDKEY))
                      .toList();
                } else {
                  docList = snapshot.data!
                      .where((element) =>
                          element.adminID == SP.sp!.getInt(SP.adminIDKEY))
                      .toList();
                }
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const MyAppBar(title: "Doctor Request Status"),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              for (int i = 0; i < buttons.length; i++)
                                MyButtonWidget(
                                  button: buttons[i],
                                  onTap: () {
                                    setState(() {
                                      for (var element in buttons) {
                                        if (element != buttons[i]) {
                                          setState(() {
                                            element['selected'] = false;
                                          });
                                          print(element);
                                        } else {
                                          setState(() {
                                            element['selected'] = true;
                                          });
                                        }
                                      }
                                    });
                                  },
                                )
                            ],
                          ),
                          const Divider(
                            color: MyColors.DarkSienna,
                            thickness: 1,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: docList.length,
                              itemBuilder: (context, index) {
                                Doctor doctor = docList[index];
                                return Card(
                                  elevation: 2,
                                  color: MyColors.Peach,
                                  child: ListTile(
                                    leading: Image.asset(
                                      doctor.image,
                                      height: 40,
                                    ),
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    dense: true,
                                    isThreeLine: true,
                                    title: Text(
                                      doctor.name,
                                      style: GoogleFonts.lato(
                                        color: MyColors.DarkSienna,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              border: Border.all(
                                                  color: MyColors.DarkSienna),
                                              color: doctor.status == 'Accepted'
                                                  ? Colors.green.shade800
                                                  : doctor.status == 'Pending'
                                                      ? MyColors.Gold
                                                      : Colors.red.shade800),
                                          child: Text(
                                            doctor.status,
                                            style: GoogleFonts.lato(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  doctor.status == 'Accepted' ||
                                                          doctor.status ==
                                                              'Rejected'
                                                      ? Colors.white
                                                      : MyColors.DarkSienna,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              children: [
                                                Text(
                                                  "Req. Date : ",
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  doctor.reqDate!,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  "Resp. Date : ",
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  doctor.respDate ?? "N/a",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
