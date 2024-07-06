import 'package:admin/functions/age_calculator.dart';
import 'package:admin/functions/random_string.dart';
import 'package:admin/functions/string_to_dob.dart';

class Receptionist {
  final String recID;
  final String image;
  final String name;
  final String gender;
  final String phone;
  final String password;
  final String dob;
  final int adminID;

  Receptionist({
    this.image = "lib/assets/profile.png",
    required this.adminID,
    required this.recID,
    required this.name,
    required this.gender,
    required this.phone,
    required this.password,
    required this.dob,
  });

  factory Receptionist.fromMap(Map<String, dynamic> map) {
    return Receptionist(
      adminID: map['adminID'],
      name: map['name'],
      recID: map['recID'],
      gender: map['gender'],
      phone: map['phone'],
      password: map['password'],
      dob: map['dob'],
    );
  }

  Map<String, dynamic> toMap() {
    int age = getAge(parseDOB(dob));
    return {
      'adminID': adminID,
      'recID': generateID(age: age, name: name, gender: gender),
      'name': name,
      'gender': gender,
      'phone': phone,
      'password': password,
      'dob': dob,
    };
  }
}
