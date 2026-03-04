import 'package:data_caching/app.dart';
import 'package:data_caching/core/injection/di.dart';
import 'package:data_caching/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  
  // 
  WidgetsFlutterBinding.ensureInitialized();

  // 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Global dependency injection setup
  await setUpDi();

  runApp(const MyApp());
  
}