import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoginEcran extends StatelessWidget {
  const LoginEcran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: [
                    Text('User Email: ${snapshot.data!.email}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign out'),
                    ),
                    Text('User is logged in'),
                  ],
                ),
              );
            }
            return SignInScreen();
          }),
    );
  }
}
