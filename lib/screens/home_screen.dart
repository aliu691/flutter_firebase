import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          GestureDetector(
            onTap: (() => FirebaseAuth.instance.signOut()),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome $user'),
      ),
    );
  }
}
