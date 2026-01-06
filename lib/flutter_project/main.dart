
import 'package:flutter/material.dart';
import 'app_shell.dart';
// import 'data/ui/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppShell(),
      // home: HomePage(),
    );
  }
}
