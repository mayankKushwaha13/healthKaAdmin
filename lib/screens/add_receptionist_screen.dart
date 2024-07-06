import 'package:admin/constants/colors.dart';
import 'package:admin/data/receptionist_database.dart';
import 'package:admin/data/receptionist_list.dart';
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/functions/age_calculator.dart';
import 'package:admin/functions/random_string.dart';
import 'package:admin/functions/string_to_dob.dart';
import 'package:admin/models/receptionist.dart';
import 'package:admin/widgets/my_appbar_widget.dart';
import 'package:admin/widgets/textFieldWidgets/add_formfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddReceptionistScreen extends StatefulWidget {
  const AddReceptionistScreen({super.key});

  @override
  State<AddReceptionistScreen> createState() => _AddReceptionistScreenState();
}

class _AddReceptionistScreenState extends State<AddReceptionistScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  bool isObscure = true;
  IconData icon = CupertinoIcons.eye_slash;
  @override
  Widget build(BuildContext context) {
    genderController.text = "Male";
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
                const MyAppBar(title: "Add Receptionist"),
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
                                    controller: dobController,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2200));
                                      if (pickedDate != null) {
                                        dobController.text =
                                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Select Date",
                                      labelStyle:
                                          GoogleFonts.lato(color: Colors.white),
                                      suffixIcon: const Icon(
                                        CupertinoIcons.calendar,
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
                              left: 10, top: 5, bottom: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select Gender : ",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                    color: MyColors.Navy,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Necessary Field";
                                      }
                                      return null;
                                    },
                                    value: genderController.text.isEmpty
                                        ? "Male"
                                        : genderController.text,
                                    iconEnabledColor: Colors.white,
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white, fontSize: 18),
                                    dropdownColor: MyColors.Navy,
                                    isExpanded: true,
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AddFormFieldWidget(
                          controller: passwordController,
                          title: "Enter Password : ",
                          obscure: isObscure,
                          password: true,
                          icon: icon,
                          onEyeTap: () {
                            setState(() {
                              isObscure = !isObscure;
                              isObscure
                                  ? icon = CupertinoIcons.eye_slash
                                  : icon = CupertinoIcons.eye;
                            });
                          },
                        ),
                        AddFormFieldWidget(
                          controller: confPassController,
                          obscure: isObscure,
                          password: true,
                          icon: icon,
                          onEyeTap: () {
                            setState(() {
                              isObscure = !isObscure;
                              isObscure
                                  ? icon = CupertinoIcons.eye_slash
                                  : icon = CupertinoIcons.eye;
                            });
                          },
                          title: "Confirm Password : ",
                        )
                      ],
                    )),
                const SizedBox(
                  height: 50,
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
                        if (passwordController.text.toString() ==
                            confPassController.text.toString()) {
                              Receptionist newRec = Receptionist(
                              adminID: SP.sp!.getInt(SP.adminIDKEY)!,
                              recID: generateID(
                                  name: nameController.text,
                                  age: getAge(parseDOB(dobController.text)),
                                  gender: genderController.text),
                              name: nameController.text,
                              gender: genderController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              dob: dobController.text);
                          recList.add(newRec);
                          ReceptionistDB().insertData(newRec);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Receptionist Added")));
                          nameController.clear();
                          phoneController.clear();
                          genderController.clear();
                          dobController.clear();
                          passwordController.clear();
                          confPassController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Password do not match. Confirm password again.")));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        "Add Receptionist",
                        style: GoogleFonts.aBeeZee(
                          color: MyColors.Peach,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
