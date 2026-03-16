import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_flutteronline_97/core/utils/colors_manager.dart';
import 'package:note_flutteronline_97/features/auth/login/presentation/screens/login.dart';
import 'package:note_flutteronline_97/features/auth/sign_up/presentation/screens/signup.dart';
import 'package:note_flutteronline_97/features/home/presentation/screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsManager.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen()
    );
  }
}


