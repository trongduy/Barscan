import 'package:barcode_scander/screen/example.dart';
import 'package:barcode_scander/screen/home_screen.dart';
import 'package:barcode_scander/screen/new_scan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BarCode',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
     // home: const ExampleScreen(),
    );
  }
}