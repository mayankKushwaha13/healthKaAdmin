
import 'package:admin/data/shared_preferences.dart';
import 'package:admin/screens/admin_profile_screen.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SP.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.indigo.shade100),
      home: const SplashScreen(),
      routes: {
        '/HomeScreen': (context) => const HomeScreen(),
        '/AdminProfile': (context) => const AdminProfileScreen()
      },
    );
  }
}
