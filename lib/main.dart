import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';
//import 'package:preview/preview.dart';
import 'scan_qr_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/scanQR': (context) => const ScanQRScreen(),
      },
    );
  }
}
