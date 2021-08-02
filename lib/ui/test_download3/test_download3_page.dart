import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TestDownload3Page extends StatefulWidget {
  TestDownload3Page({Key? key}) : super(key: key);

  @override
  _TestDownload3PageState createState() => _TestDownload3PageState();
}

class _TestDownload3PageState extends State<TestDownload3Page> {
  Dio _dio = Dio();
  bool _loading = false;
  double _progress = 0;

  void _downloadFile() async {
    setState(() {
      _loading = true;
      _progress = 0;
    });

    // start of save video
    try {
      Directory? dir;

      // start of request permission
      if (await Permission.storage.isGranted) {
        dir = await getExternalStorageDirectory();
        String newPath = "";
        print(dir);
        List<String>? paths = dir?.path.split("/");
        if (paths != null) {
          for (int i = 1; i < paths.length; i++) {
            if (paths[i] != "Android")
              newPath += "/" + paths[i];
            else
              break;
          }

          newPath = newPath + "/FlutterDota2Chatwheel";
          dir = Directory(newPath);

          File saveFile = File(dir.path + "/test_chatwheel.mp3");
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          if (await dir.exists()) {
            await _dio.download(
              "https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137",
              saveFile.path,
              onReceiveProgress: (val1, val2) {
                setState(() {
                  _progress = val1 / val2;
                });
              },
            );
          }
        } else {
          print('download failed, permission problem');
        }
      } else {
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.granted) {
          dir = await getExternalStorageDirectory();
          String newPath = "";
          print(dir);
          List<String>? paths = dir?.path.split("/");
          if (paths != null) {
            for (int i = 1; i < paths.length; i++) {
              if (paths[i] != "Android")
                newPath += "/" + paths[i];
              else
                break;
            }

            newPath = newPath + "FlutterDota2Chatwheel";
            dir = Directory(newPath);

            File saveFile = File(dir.path + "/test_chatwheel.mp3");
            if (!await dir.exists()) {
              await dir.create(recursive: true);
            }
            if (await dir.exists()) {
              await _dio.download(
                "https://static.wikia.nocookie.net/dota2_gamepedia/images/f/fc/Misc_soundboard_rimshot.mp3/revision/latest?cb=20190922222137",
                saveFile.path,
                onReceiveProgress: (val1, val2) {
                  setState(() {
                    _progress = val1 / val2;
                  });
                },
              );
            }
          } else {
            print('download failed, permission problem');
          }
        } else {
          _downloadFile();
        }
      }

      // end of request permission
    } catch (e) {
      print(e);
      print('download failed, exception happend');
    }
    // end of save video
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Download3 Page'),
      ),
      body: Center(
        child: _loading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: _progress,
                ),
              )
            : TextButton(
                onPressed: _downloadFile,
                child: Text('Download Chatwheel'),
              ),
      ),
    );
  }
}
