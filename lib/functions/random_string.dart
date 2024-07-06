import 'dart:math';

String generateID({required String name,required int age, required String gender}) {
  var r = Random();
  // const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String s = "${name[0]}te$age${r.nextInt(10000)+1000}";
  // return List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
  return s;
}
