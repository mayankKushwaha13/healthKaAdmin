import 'package:admin/constants/colors.dart';
import 'package:admin/constants/weekdays.dart';
import 'package:admin/widgets/textFieldWidgets/edit_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBoxDoctorWidget extends StatefulWidget {
  const EditBoxDoctorWidget({
    super.key,
    required this.visibility,
    required this.nameController,
    required this.daysController,
    required this.phoneController,
    required this.stimeController,
    required this.etimeController,
    required this.clinicNameController,
    this.onTap,
    this.onBack,
    this.days,
  });
  final bool visibility;
  final TextEditingController nameController;
  final TextEditingController daysController;
  final TextEditingController phoneController;
  final TextEditingController stimeController;
  final TextEditingController etimeController;
  final TextEditingController clinicNameController;
  final void Function()? onTap;
  final void Function()? onBack;
  final List<String>? days;

  @override
  State<EditBoxDoctorWidget> createState() => _EditBoxDoctorWidgetState();
}

class _EditBoxDoctorWidgetState extends State<EditBoxDoctorWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var map in weekdays) {
      map['isChecked'] = false;
      for (int i = 0; i < widget.days!.length; i++) {
        if (widget.days![i].toString() ==
            map['day'].substring(0, 3).toString()) {
          map['isChecked'] = true;
          break;
        }
      }
    }
    return SingleChildScrollView(
      child: Visibility(
        visible: widget.visibility,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: MyColors.Rosewood,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Text(
                      "Edit Receptionist Data",
                      style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(
                  height: 10,
                ),
                EditTextField(
                    controller: widget.nameController, title: "Enter Name : "),
                const SizedBox(
                  height: 10,
                ),
                EditTextField(
                    controller: widget.phoneController,
                    title: "Enter Phone : "),
                const SizedBox(
                  height: 10,
                ),
                EditTextField(
                    controller: widget.clinicNameController,
                    title: "Enter Clinic Name : "),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Wrap(
                      children: weekdays.map((map) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Card(
                        color: MyColors.FadedBlue,
                        child: CheckboxListTile(
                            activeColor: MyColors.Cobalt,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            title: Text(
                              map['day'],
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColors.Navy2),
                            ),
                            value: map['isChecked'],
                            onChanged: (val) {
                              setState(() {
                                map['isChecked'] = val;
                              });
                            }),
                      );
                    });
                  }).toList()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        "Enter Start Time :",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                color: Colors.black),
                            controller: widget.stimeController,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 14, minute: 00),
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  widget.stimeController.text =
                                      "${pickedTime.hour}:${pickedTime.minute}";
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Select Time",
                              labelStyle: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              suffixIcon: const Icon(
                                CupertinoIcons.time,
                                size: 30,
                                color: MyColors.Red,
                              ),
                              isDense: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              fillColor: MyColors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        "Enter End Time :",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                color: Colors.black),
                            controller: widget.etimeController,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime:
                                    const TimeOfDay(hour: 18, minute: 00),
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  widget.etimeController.text =
                                      "${pickedTime.hour}:${pickedTime.minute}";
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Select Time",
                              labelStyle: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              suffixIcon: const Icon(
                                CupertinoIcons.time,
                                size: 30,
                                color: MyColors.Red,
                              ),
                              isDense: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              fillColor: MyColors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: widget.onBack,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: MyColors.Navy,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Close (Without Saving)",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                    TextButton(
                        onPressed: widget.onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: MyColors.Navy,
                            borderRadius: BorderRadius.circular(8),
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
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
