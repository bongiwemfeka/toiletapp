// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'forgot_password_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set white background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/welcome.png', // Replace with the path to your Ferrari sign image
              width: 300.0,
              height: 250.0,
            ),
            SizedBox(height: 50.0),
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Set text color to green
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set green button color
                padding: EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0), // Add padding
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 18.0), // Set button text size
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you do not have a profile, you can register.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.green, // Set green text color
              ),
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 16.0), // Set text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
