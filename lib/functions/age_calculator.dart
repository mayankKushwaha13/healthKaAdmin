int getAge(DateTime dob) {
  int age = DateTime.now().day >= dob.day && DateTime.now().month >= dob.month
      ? DateTime.now().year - dob.year
      : DateTime.now().year - dob.year - 1;

  return age;
}
