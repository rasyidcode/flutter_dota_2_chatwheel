import 'dart:io';

extension StringExtensions on String {
  Future<bool> isFileExist() async {
    return await File(this).exists();
  }
}
