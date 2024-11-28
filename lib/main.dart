import 'package:flutter/material.dart';
import 'package:hive_1/session_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open a box for session data
  await Hive.openBox('sessionBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Session Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SessionManager(),
    );
  }
}
