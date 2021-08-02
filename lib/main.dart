import 'package:flutter/material.dart';
import 'package:flutter_dota_2_chatwheel/injection_container.dart';
import 'package:flutter_dota_2_chatwheel/ui/home/home_page.dart';
import 'package:flutter_dota_2_chatwheel/ui/test_download/test_download_page.dart';
import 'package:flutter_dota_2_chatwheel/ui/test_download2/test_download2_page.dart';
import 'package:flutter_dota_2_chatwheel/ui/test_download3/test_download3_page.dart';
import 'package:flutter_dota_2_chatwheel/ui/test_ui.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
