import 'package:flutter/material.dart';

class TestUIPage extends StatefulWidget {
  TestUIPage({Key? key}) : super(key: key);

  @override
  _TestUIPageState createState() => _TestUIPageState();
}

class _TestUIPageState extends State<TestUIPage> {
  bool _isDownloading = false;
  bool _isDownloaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test UI'),
      ),
      body: Center(
        child: _isDownloading
            ? CircularProgressIndicator(
                value: 0,
              )
            : _isDownloaded
                ? IconButton(
                    onPressed: () {
                      print('play pressed');
                    },
                    icon: Icon(
                      Icons.play_arrow,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      print('download pressed');
                    },
                    icon: Icon(
                      Icons.download,
                    ),
                  ),
      ),
    );
  }
}
