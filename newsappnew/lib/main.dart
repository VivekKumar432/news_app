import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsappnew/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MyHomepage(),
    debugShowCheckedModeBanner: false,
  ));
}
