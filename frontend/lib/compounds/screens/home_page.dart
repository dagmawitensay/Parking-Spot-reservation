import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spot Reservation App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to the Parking Spot Reservation App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              'Find and reserve parking spots conveniently!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                (context).goNamed('ownerSignup');
              },
              child: Text('Sign Up as Compound Owner'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                (context).goNamed('reserverSignup');
              },
              child: const Text('Sign Up as Spot User'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                (context).goNamed('signin');
              },
              child: const Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
