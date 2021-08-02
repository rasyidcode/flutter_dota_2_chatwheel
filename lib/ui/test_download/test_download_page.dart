import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TestDownloadPage extends StatefulWidget {
  TestDownloadPage({Key? key}) : super(key: key);

  @override
  _TestDownloadPageState createState() => _TestDownloadPageState();
}

class _TestDownloadPageState extends State<TestDownloadPage> {
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$progress', style: TextStyle(fontSize: 40.0)),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () async {
                final status = await Permission.storage.request();

                if (status.isGranted) {
                  final externalDir = await getExternalStorageDirectory();

                  final id = await FlutterDownloader.enqueue(
                      url:
                          "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41",
                      savedDir: externalDir!.path,
                      fileName: "download",
                      showNotification: true,
                      openFileFromNotification: true);
                } else {
                  print('permission denied');
                }
              },
              child: Text(
                'Start download',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  static void downloadingCallback(
      String id, DownloadTaskStatus status, int progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    sendPort?.send([id, status, progress]);
  }
}
