import 'package:flutter/material.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/Appconstants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.initialize();
  runApp(const MainApp());
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopScope(
        child: MainScreen(currentIndex: 0,),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
