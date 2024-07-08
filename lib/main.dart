
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_gate.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/pages/register_page.dart';
import 'package:untitled/themes/light_mode.dart';
import 'package:untitled/themes/theme_provider.dart';

import 'auth/login_or_register.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp( const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      //const MyApp()
ChangeNotifierProvider(
  create: (context) => ThemeProvider(),
  child: const MyApp(),
)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const AuthGate(),
       theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}


