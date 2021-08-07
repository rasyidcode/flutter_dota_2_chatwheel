import 'package:dio/dio.dart';

Future<Null> downloadLine(Dio dio, String lineUrl, String saveTo) async {
  await dio.download(
    lineUrl,
    saveTo,
    onReceiveProgress: (val1, val2) {
      double progress = val1 / val2;
      print(progress);
    },
  );
}
