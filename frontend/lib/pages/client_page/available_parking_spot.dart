import 'package:flutter/material.dart';
import 'package:tester/models/park_compund.dart';

class FreeSpotsPage extends StatelessWidget {
  final ParkCompound parkCompound;

  const FreeSpotsPage({Key? key, required this.parkCompound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logic for fetching the list of free parking spots based on the search filter method
    // You can use the parkCompound and other filter values to fetch the data from the database or API

    // Dummy list of free parking spots for demonstration purposes
    List<ParkingSpot> freeParkingSpots = [
      ParkingSpot(id: 1, spotNumber: 'A1'),
      ParkingSpot(id: 2, spotNumber: 'B2'),
      ParkingSpot(id: 3, spotNumber: 'C3'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Parking Spots'),
      ),
      body: ListView.builder(
        itemCount: freeParkingSpots.length,
        itemBuilder: (context, index) {
          final parkingSpot = freeParkingSpots[index];
          return ListTile(
            title: Text(parkingSpot.spotNumber),
            trailing: ElevatedButton(
              child: const Text('Book'),
              onPressed: () {},
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

class ParkingSpot {
  final int id;
  final String spotNumber;

  ParkingSpot({required this.id, required this.spotNumber});
}
