import 'package:admin/functions/age_calculator.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/data/admin_database.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/functions/string_to_dob.dart';
import 'package:admin/widgets/drawer_widget.dart';
import 'package:admin/widgets/textFieldWidgets/edit_textfield_widget.dart';
import 'package:admin/widgets/information_text_widget.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  bool isVisible = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int? adminID;
  var admin;

  // void getUser() async {
  //   var list = await AdminDatabase().readData();
  //   list.forEach(printmy);
  // }

  // void printmy(Admin admin) {
  //   print(admin.firstName);
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: AdminDatabase().readData(),
            builder: (context, snapshot) {
              adminID = SP.sp!.getInt(SP.adminIDKEY);
              admin = snapshot.data!.where((admin)=>admin.adminID==adminID).first;
              if (admin != null) {
                // getUser();
                String firstName = admin.firstName;
                String lastName = admin.lastName;
                String gender = admin.gender;
                String phone = admin.phone;
                String address = admin.address;
                DateTime dob = parseDOB(admin.dob);
                int age = getAge(dob);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        const MyAppBar(title: "Admin Profile"),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                "lib/assets/admin.png",
                                width: 150,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    color: MyColors.Seashell,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "$firstName $lastName",
                                    style: GoogleFonts.slabo13px(
                                      color: MyColors.DarkSienna,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(horizontal: 13),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: MyColors.Navy,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Personal Information",
                                      style: GoogleFonts.josefinSans(
                                        color: MyColors.Peach,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisible = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: MyColors.Gold,
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 10),
                                child: Column(
                                  children: [
                                    InformationTextWidget(
                                        text1: "D.O.B",
                                        text2: "${dob.day}/${dob.month}/${dob.year}"),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    InformationTextWidget(
                                        text1: "Age", text2: age.toString()),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    InformationTextWidget(
                                        text1: "Gender", text2: gender),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    InformationTextWidget(
                                        text1: "Phone Number", text2: phone),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      runAlignment: WrapAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                        ),
                                        Text(
                                          "Address : ",
                                          style: GoogleFonts.aBeeZee(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          address,
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      child: Visibility(
                        visible: isVisible,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: MyColors.Navy,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: MyColors.Rosewood,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: Text(
                                      "Edit Your Profile",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextField(
                                  controller: firstNameController,
                                  title: "First Name",
                                ),
                                EditTextField(
                                  controller: lastNameController,
                                  title: "Last Name",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Enter D.O.B :",
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TextField(
                                            readOnly: true,
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold),
                                            controller: dobController,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2200));
                                              if (pickedDate != null) {
                                                dobController.text = "${pickedDate
                                                        .day}/${pickedDate.month}/${pickedDate.year}";
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              labelText: "Select Date",
                                              suffixIcon: Icon(
                                                CupertinoIcons.calendar,
                                                size: 30,
                                                color: MyColors.RedDark,
                                              ),
                                              isDense: true,
                                              enabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black54),
                                              ),
                                              focusedBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black87),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Gender : ",
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 8, right: 8),
                                        decoration: const BoxDecoration(
                                          color: MyColors.Burgundy,
                                        ),
                                        child: DropdownButton<String>(
                                          value: genderController.text.isEmpty
                                              ? "Male"
                                              : genderController.text,
                                          iconEnabledColor: Colors.white,
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.white,
                                              fontSize: 18),
                                          dropdownColor: MyColors.Burgundy,
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() {
                                                genderController.text = value;
                                              });
                                            }
                                          },
                                          items: [
                                            DropdownMenuItem(
                                              value: "Male",
                                              child: Text(
                                                "Male",
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "Female",
                                              child: Text(
                                                "Female",
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                EditTextField(
                                  controller: phoneController,
                                  title: "Phone Number",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                            if (firstNameController
                                                .text.isNotEmpty) {
                                              await AdminDatabase().updateData(
                                                  admin.adminID, {
                                                'firstName':
                                                    firstNameController.text
                                              });
                                            }
                                            if (lastNameController
                                                .text.isNotEmpty) {
                                              await AdminDatabase().updateData(
                                                  admin.adminID, {
                                                'lastName':
                                                    lastNameController.text
                                              });
                                            }
                                            if (dobController.text.isNotEmpty) {
                                              dob = parseDOB(dobController.text);
                                              await AdminDatabase().updateData(
                                                  admin.adminID,
                                                  {'dob': dobController.text});
                                            }
                                            if (genderController
                                                .text.isNotEmpty) {
                                              await AdminDatabase().updateData(
                                                  admin.adminID, {
                                                'gender': genderController.text
                                              });
                                            }
                                            if (phoneController
                                                .text.isNotEmpty) {
                                              await AdminDatabase().updateData(
                                                  admin.adminID, {
                                                'phone': phoneController.text
                                              });
                                            }
                                          firstNameController.clear();
                                          lastNameController.clear();
                                          genderController.clear();
                                          dobController.clear();
                                          phoneController.clear();
                                          setState(() {
                                            isVisible = false;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: MyColors.Burgundy,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.aBeeZee(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: MyColors.Burgundy,
                ));
              }
            }),
      ),
    );
  }
}
