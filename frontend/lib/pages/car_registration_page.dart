import 'package:flutter/material.dart';

class ParkingSpot {
  final int id;
  final String spotNumber;

  ParkingSpot({required this.id, required this.spotNumber});
}

class CarRegistrationPage extends StatefulWidget {
  final ParkingSpot parkingSpot;

  const CarRegistrationPage({Key? key, required this.parkingSpot})
      : super(key: key);

  @override
  _CarRegistrationPageState createState() => _CarRegistrationPageState();
}

class _CarRegistrationPageState extends State<CarRegistrationPage> {
  String carModel = '';
  String licensePlate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Car Registration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Car Model',
              ),
              onChanged: (value) {
                setState(() {
                  carModel = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'License Plate',
              ),
              onChanged: (value) {
                setState(() {
                  licensePlate = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform car registration logic here
                // You can save the car details to the database, etc.
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
