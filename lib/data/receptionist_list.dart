import 'package:admin/functions/age_calculator.dart';
import 'package:admin/functions/random_string.dart';
import 'package:admin/functions/string_to_dob.dart';
import 'package:admin/models/receptionist.dart';

List<Receptionist> recList = [
  Receptionist(
      adminID: 2,
      recID: generateID(
          name: "maiHuReceptionist",
          age: getAge(parseDOB('2/2/2002')),
          gender: "Female"),
      name: "maiHuReceptionist",
      dob: '2/2/2002',
      gender: "Female",
      password: "pass2",
      phone: "9876543210"),
  Receptionist(
      adminID: 1,
      recID: generateID(
          name: "firAayaReceptionist",
          age: getAge(parseDOB('3/3/2003')),
          gender: "Male"),
      name: "firAayaReceptionist",
      dob: '3/3/2003',
      gender: "Female",
      password: "pass3",
      phone: "9876543210")
];
