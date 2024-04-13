import 'package:flutter/material.dart';
import 'package:SkyView/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopScope(
        child: MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
