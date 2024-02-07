import 'package:flutter/material.dart';
import 'package:toiletapp/login_screen.dart';
import 'package:toiletapp/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Screen',
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 100.0), // Replace with your app logo
            SizedBox(height: 20.0),
            Text(
              'Welcome to MyApp!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Your gateway to seamless experiences.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                // Implement login logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanQRScreen(),
                  ),
                );
              },
              child: Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
