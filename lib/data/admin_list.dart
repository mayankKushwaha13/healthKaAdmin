import 'package:admin/models/admin.dart';

List<Map<String, Object?>> adminList = [
  {
    'admin': Admin(
        adminID: 1,
        firstName: "Admin1",
        lastName: "LastName1",
        gender: "Male",
        phone: "9876543210",
        address: "street/locality/pincode/city/state",
        dob: "1/1/2001"),
    'password': 'pass1'
  },
  {
    'admin': Admin(
        adminID: 2,
        firstName: "Admin2",
        lastName: "LastName2",
        gender: "Female",
        phone: "9999999999",
        address: "street/locality/pincode/city/state",
        dob: "1/1/2002"),
    'password': 'pass2'
  }
];

List userList = adminList.map((map) => map['admin']).toList();
