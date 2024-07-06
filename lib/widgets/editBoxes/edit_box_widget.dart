import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/textFieldWidgets/edit_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBoxWidget extends StatefulWidget {
  const EditBoxWidget({
    super.key,
    required this.visibility,
    required this.nameController,
    required this.dobController,
    required this.phoneController,
    required this.genderController,
    this.onTap,
    this.gender,
    this.onBack,
  });
  final bool visibility;
  final TextEditingController nameController;
  final TextEditingController dobController;
  final TextEditingController phoneController;
  final TextEditingController genderController;
  final void Function()? onTap;
  final void Function()? onBack;
  final String? gender;

  @override
  State<EditBoxWidget> createState() => _EditBoxWidgetState();
}

class _EditBoxWidgetState extends State<EditBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Visibility(
        visible: widget.visibility,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Container(
            height: MediaQuery.of(context).size.height - 90,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            readOnly: true,
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                            controller: widget.dobController,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2200));
                              if (pickedDate != null) {
                                widget.dobController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Gender : ",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                              color: MyColors.white,
                              borderRadius: BorderRadius.circular(4)),
                          child: DropdownButton<String>(
                            underline: Container(),
                            isExpanded: true,
                            value: widget.genderController.text.isEmpty
                                ? widget.gender
                                : widget.genderController.text,
                            iconEnabledColor: Colors.black,
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black, fontSize: 18),
                            dropdownColor: MyColors.white,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  widget.genderController.text = value;
                                });
                              }
                            },
                            items: [
                              DropdownMenuItem(
                                value: "Male",
                                child: Text(
                                  "Male",
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Female",
                                child: Text(
                                  "Female",
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EditTextField(
                    controller: widget.phoneController,
                    title: "Enter Phone : "),
                const SizedBox(
                  height: 10,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
