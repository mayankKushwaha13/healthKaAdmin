class Doctor {
  final String docID;
  final String image;
  final String name;
  final String spec;
  final String phone;
  final String clinicName;
  final String days;
  final String stime;
  final String etime;
  final String status;
  final String? reqDate;
  final String? respDate;
  final int adminID;

  Doctor({
    this.image = "lib/assets/profile2.png",
    this.reqDate,
    this.respDate,
    required this.adminID,
    required this.docID,
    required this.name,
    required this.spec,
    required this.phone,
    required this.clinicName,
    required this.days,
    required this.stime,
    required this.etime,
    required this.status,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      adminID: map['adminID'],
      name: map['name'],
      docID: map['docID'],
      spec: map['spec'],
      phone: map['phone'],
      clinicName: map['clinicName'],
      days: map['days'],
      stime: map['stime'],
      etime: map['etime'],
      status : map['status'],
      reqDate: map['reqDate'],
      respDate: map['respDate']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminID': adminID,
      'docID': docID,
      'name': name,
      'spec': spec,
      'phone': phone,
      'clinicName': clinicName,
      'days': days,
      'stime': stime,
      'etime': etime,
      'status' : status,
      'reqDate' : reqDate,
      'respDate' : respDate,
    };
  }
}
