import 'package:flutter/material.dart';
import 'package:todo_list/app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() async{
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
//   runApp(const AppModule());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppModule());
}