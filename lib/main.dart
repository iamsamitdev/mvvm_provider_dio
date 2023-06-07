import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_dio/app.dart';

void main() async {
  // make sure that all the services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Intialize firebase
  await Firebase.initializeApp();

  runApp(App());
}