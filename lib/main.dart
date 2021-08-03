import 'package:flutter/material.dart';
import 'package:flutter_dota_2_chatwheel/injection_container.dart';
import 'package:flutter_dota_2_chatwheel/ui/test_joystick/test_joystick_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Joypad(),
        ),
      ),
    );
  }
}
