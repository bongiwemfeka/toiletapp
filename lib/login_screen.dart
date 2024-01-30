import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png', // Replace with your logo image path
                  width: 200,
                  height: 150,
                ),
                const SizedBox(height: 20),

                // Username TextField
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password TextField
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 38, 155, 77).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Implement login logic
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
