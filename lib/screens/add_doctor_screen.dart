import 'package:admin/constants/colors.dart';
import 'package:admin/constants/weekdays.dart';
import 'package:admin/data/doctors_database.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/functions/today_date.dart';
import 'package:admin/models/doctor.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:admin/widgets/textFieldWidgets/add_formfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController docIDController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController stimeController = TextEditingController();
  final TextEditingController etimeController = TextEditingController();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
            child: Column(
              children: [
                const MyAppBar(title: "Add Doctor"),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AddFormFieldWidget(
                          controller: nameController,
                          title: "Enter Name : ",
                        ),
                        AddFormFieldWidget(
                          controller: phoneController,
                          title: "Enter Phone : ",
                          numbersOnly: true,
                        ),
                        AddFormFieldWidget(
                            controller: docIDController,
                            title: "Enter Doc ID : "),
                        AddFormFieldWidget(
                            controller: specController,
                            title: "Enter Specialisation"),
                        AddFormFieldWidget(
                            controller: clinicNameController,
                            title: "Enter Clinic Name"),
                        Wrap(
                            children: weekdays.map((map) {
                          return Card(
                            color: MyColors.Gold,
                            child: CheckboxListTile(
                                activeColor: MyColors.Cobalt,
                                checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                title: Text(
                                  map['day'],
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                value: map['isChecked'],
                                onChanged: (val) {
                                  setState(() {
                                    map['isChecked'] = val;
                                  });
                                }),
                          );
                        }).toList()),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                "Enter Start Time :",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Necessary Field";
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    controller: stimeController,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 14, minute: 00),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          stimeController.text =
                                              "${pickedTime.hour}:${pickedTime.minute}";
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Select Time",
                                      labelStyle:
                                          GoogleFonts.lato(color: Colors.white),
                                      suffixIcon: const Icon(
                                        CupertinoIcons.time,
                                        size: 30,
                                        color: MyColors.Red,
                                      ),
                                      isDense: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                      fillColor: MyColors.Navy,
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
                              left: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                "Enter End Time :",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Necessary Field";
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    controller: etimeController,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 18, minute: 00),
                                      );
                                      if (pickedTime != null) {
                                        setState(() {
                                          etimeController.text =
                                              "${pickedTime.hour}:${pickedTime.minute}";
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Select Time",
                                      labelStyle:
                                          GoogleFonts.lato(color: Colors.white),
                                      suffixIcon: const Icon(
                                        CupertinoIcons.time,
                                        size: 30,
                                        color: MyColors.Red,
                                      ),
                                      isDense: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black87),
                                      ),
                                      fillColor: MyColors.Navy,
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Ink(
                  decoration: BoxDecoration(
                    color: MyColors.Burgundy,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (stimeController.text.toString() !=
                            etimeController.text.toString()) {
                              List days = [];
                              for (var element in weekdays) {
                                if(element['isChecked']){
                                  days.add(element['day'].substring(0,3));
                                  setState(() {
                                    element['isChecked'] = false;
                                  });
                                }
                              }
                              daysController.text = days.join(", ");
                          Doctor newDoc = Doctor(
                              status: "Pending",
                              reqDate: todayDate(),
                              adminID: SP.sp!.getInt(SP.adminIDKEY)!,
                              docID: docIDController.text,
                              name: nameController.text,
                              spec: specController.text,
                              phone: phoneController.text,
                              clinicName: clinicNameController.text,
                              days: daysController.text,
                              stime: stimeController.text,
                              etime: etimeController.text);
                              DoctorsDB().insertData(newDoc);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Doctor Added")));
                          nameController.clear();
                          phoneController.clear();
                          specController.clear();
                          docIDController.clear();
                          clinicNameController.clear();
                          stimeController.clear();
                          etimeController.clear();
                          daysController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Start Time and End Time can not be the same")));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        "Add Doctor",
                        style: GoogleFonts.aBeeZee(
                          color: MyColors.Peach,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
