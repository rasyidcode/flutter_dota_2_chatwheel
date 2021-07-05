import 'dart:io';

String fixtures(String pathName, String name) =>
    File('test/data/fixtures/$pathName/$name.html').readAsStringSync();
