import 'package:data_caching/app.dart';
import 'package:data_caching/core/dependency_injection/di.dart';
import 'package:flutter/material.dart';

void main() async {
  // Hive initialization
  WidgetsFlutterBinding.ensureInitialized();

  /* Dependency injection setup
  Wait for the dependency injection setup to complete before running the app */
  await setUpDi();

  runApp(const MyApp());
}