parseDOB(String dob) {
  var temp = dob.split("/");
  return DateTime(
    double.parse(temp[2]).toInt(),
    double.parse(temp[1]).toInt(),
    double.parse(temp[0]).toInt(),
  );
}
