import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_dio/app.dart';

// firebase message handler
Future<void> _messageHandler(RemoteMessage message) async {
  if(kDebugMode){
    print('background message ${message.notification!.body}');
  }
}

void main() async {
  // make sure that all the services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Intialize firebase
  await Firebase.initializeApp();

  // firebase messaging background handler
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const App());
}