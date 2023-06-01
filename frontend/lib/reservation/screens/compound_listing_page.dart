import 'package:flutter/material.dart';
import 'package:frontend/reservation/bloc/compound_bloc.dart';
import 'package:frontend/reservation/models/parking_compound.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompoundListingPage extends StatelessWidget {
  const CompoundListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Compounds'),
      ),
      body: BlocBuilder<ParkingCompoundBloc, ParkingCompoundState>(
        builder: (context, state) {
          if (state is ParkingCompoundLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ParkingCompoundLoaded) {
            return _buildCompoundList(state.compounds);
          } else if (state is ParkingCompoundError) {
            return const Center(child: Text('Failed to load compounds'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildCompoundList(List<ParkingCompound> compounds) {
    return ListView.builder(
      itemCount: compounds.length,
      itemBuilder: (context, index) {
        final compound = compounds[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/park-spot/${compound.id}');
          },
          child: ListTile(
            // leading: Image.network(
            //   compound.imageUrl, // to do
            //   width: 48,
            //   height: 48,
            // ),
            title: Text(compound.name),
            subtitle: Text(
              'Price: \$${compound.price.toStringAsFixed(2)} | Location: ${compound.name}',
            ),
          ),
        );
      },
    );
  }
}
