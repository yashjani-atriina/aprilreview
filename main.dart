import 'package:aprilreview/add_employee.dart';
import 'package:aprilreview/online_code/add_employee_online.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternetConnection = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    hasInternetConnection = await InternetConnectionChecker().hasConnection;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!hasInternetConnection) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddEmployee(), //sqflite code
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddEmployeeScreen(), //firebase code
      );
    }
  }
}
