// user_profile_screen.dart
import 'package:flutter/material.dart';
//import 'user.dart'; // Import the User model
// user.dart

class User {
  final String name;
  final String email;
  final String profileImageUrl;

  User(
      {required this.name, required this.email, required this.profileImageUrl});
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Future<User> getCurrentUser() async {
    // Simulate a network request delay
    await Future.delayed(const Duration(seconds: 2));

    // Return mock user data
    return User(
        name: 'Bongiwe Mfeka',
        email: 'bongiwe@ascentza.co.za',
        profileImageUrl: 'https://via.placeholder.com/150');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder<User>(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profileImageUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  // ... additional profile details and options ...
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
