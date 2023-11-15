import 'package:advanced_flutter/presentation/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends  StatefulWidget {

  // default constructor , It is not instance  يعني عايزة استدعي الكونستراكتور ده مرة واحده
  //const MyApp({super.key});

  // named constructor
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp()  => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
