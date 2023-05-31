import 'dart:convert';
import 'package:frontend/reservation/bloc/parking_spot_bloc.dart';
import 'package:frontend/reservation/data_provider/parking_spot_data_provider.dart';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:frontend/reservation/repository/parking_spot_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkSpotPage extends StatefulWidget {
  final String compoundId;

  const ParkSpotPage({super.key, required this.compoundId});

  @override
  ParkSpotPageState createState() => ParkSpotPageState();
}

class ParkSpotPageState extends State<ParkSpotPage> {
  final ScrollController _scrollController = ScrollController();
  late ParkingSpotBloc _parkingSpotBloc;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _parkingSpotBloc = ParkingSpotBloc(
      parkingSpotRepository: ParkingSpotRepository(
        parkingSpotDataProvider: ParkingSpotDataProvider(),
      ),
    );
    _parkingSpotBloc.add(LoadParkingSpots(page: _currentPage));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _parkingSpotBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _parkingSpotBloc.add(LoadParkingSpots(page: _currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Park Spot Page'),
      ),
      body: BlocBuilder<ParkingSpotBloc, ParkingSpotState>(
        bloc: _parkingSpotBloc,
        builder: (context, state) {
          if (state is ParkingSpotLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ParkingSpotLoaded) {
            return _buildParkingSpotsList(
                state.parkingSpots, state.hasMoreData);
          } else if (state is ParkingSpotError) {
            return const Center(
              child: Text('Failed to load parking spots.'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildParkingSpotsList(
      List<ParkingSpot> parkingSpots, bool hasMoreData) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: parkingSpots.length + (hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < parkingSpots.length) {
          final parkingSpot = parkingSpots[index];
          return _buildParkingSpotItem(parkingSpot);
        } else {
          return ElevatedButton(
            onPressed: () {
              _currentPage++;
              _parkingSpotBloc.add(LoadParkingSpots(page: _currentPage));
            },
            child: const Text('Next Page'),
          );
        }
      },
    );
  }

// ...

  Widget _buildParkingSpotItem(ParkingSpot parkingSpot) {
    return FutureBuilder<bool>(
      future: _checkSpotAvailability(parkingSpot.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!) {
          return GestureDetector(
            onTap: () {
              GoRouter.of(context)
                  .go('/time-picker?parkingSpot=${parkingSpot.id}');
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  'Spot ID: ${parkingSpot.id}',
                  textAlign: TextAlign.center,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle booking logic
                  },
                  child: const Text('Book'),
                ),
              ),
              child: Column(
                children: [
                  Image.asset('path_to_image'),
                  Text('Spot ID: ${parkingSpot.id}'),
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              Image.asset('path_to_image'),
              Text('Spot ID: ${parkingSpot.id}'),
            ],
          );
        }
      },
    );
  }

  Future<bool> _checkSpotAvailability(int parkingSpotId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:3000/reservations?parking_spot_id=$parkingSpotId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.isEmpty;
      } else {
        throw Exception('Failed to check availability');
      }
    } catch (e) {
      // Handle any errors that occur during the availability check
      // ignore: avoid_print
      print('Failed to check spot availability: $e');
      return false;
    }
  }
}
