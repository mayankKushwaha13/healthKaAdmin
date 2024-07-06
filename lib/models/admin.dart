class Admin{

  final int adminID;
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final String address;
  final String dob;

  Admin(
    {
      required this.adminID,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.phone,
      required this.address,
      required this.dob,
    }
  );

  factory Admin.fromMap(Map<String, dynamic> map){
    return Admin(
      adminID: map['adminID'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      phone: map['phone'],
      address: map['address'],
      dob: map['dob'],
    );
  }

  Map<String, Object?> toMap(){
    return {
      'adminID' : adminID,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phone': phone,
      'address' : address,
      'dob': dob,
    };
  }
}