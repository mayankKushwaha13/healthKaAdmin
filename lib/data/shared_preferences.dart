import 'package:shared_preferences/shared_preferences.dart';

class SP {      
  static SharedPreferences? sp;
  static String adminIDKEY = "adminID";
  static String receptionistKEY = "receptionist";
  static String login = "login";
  static Future init() async {
    sp = await SharedPreferences.getInstance();
  }
}
