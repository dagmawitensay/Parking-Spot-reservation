import 'package:flutter/material.dart';

import '../../models/Client.dart';

class ClientProfileInfo extends StatelessWidget {
  final Client client;
  const ClientProfileInfo({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Client Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Name: ${client.name}'),
            const SizedBox(height: 16),
            Text('Email: ${client.email}'),
            // Add more profile information here
          ],
        ),
      ),
    );
  }
}
