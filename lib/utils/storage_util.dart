import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File?> getLineFileStorage(String fileName) async {
  Directory? dir = await getExternalStorageDirectory();
  String newPath = "";

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
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    String savedPath = dir.path + "/$fileName.mp3";
    File saveFile = File(savedPath);
    return saveFile;
  }
}
