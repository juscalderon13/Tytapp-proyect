import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tytapp/src/pages/client/map/client_map_page.dart';
import 'package:tytapp/src/pages/driver/map/driver_map_page.dart';
import 'package:tytapp/src/pages/driver/register/driver_register_page.dart';
import 'firebase_options.dart';
import 'package:tytapp/src/pages/home/home_page.dart';
import 'package:tytapp/src/pages/login/login_page.dart';
import 'package:tytapp/src/pages/client/register/client_register_page.dart';
import 'package:tytapp/src/utils/colors.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Tytapp",
        debugShowCheckedModeBanner: false,
        initialRoute: "HomeApp",
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            fontFamily: "NimbusSans",
            appBarTheme: const AppBarTheme(elevation: 0, color: Colors.amber),
            primaryColor: utils.Colors.azulOscuro),
        routes: {
          "HomeApp": (BuildContext context) => HomePage(),
          "LoginPage": (BuildContext context) => const LoginPage(),
          "ClientRegisterPage": (BuildContext context) =>
              const ClientRegisterPage(),
          "DriverRegisterPage": (BuildContext context) =>
              const DriverRegisterPage(),
          "DriverMapPage": (BuildContext context) => const DriverMapPage(),
          "ClientMapPage": (BuildContext context) => const ClientMapPage(),
        });
  }
}
