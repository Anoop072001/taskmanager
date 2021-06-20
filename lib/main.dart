import 'dart:io';
import 'package:dio/dio.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskmanager/List_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  Hive.init(appDocPath);
  await Hive.openBox<String>("Task");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: List_page(),
    );
  }
}
