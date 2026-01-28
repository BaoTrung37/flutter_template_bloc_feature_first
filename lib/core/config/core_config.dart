import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

abstract class CoreConfig {
  Future<void> init();

  String get title;

  FirebaseOptions get firebaseOptions;

  bool get isDev;
}
