import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_state.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:go_router/go_router.dart';

class CompoundListingPage extends StatelessWidget {
  const CompoundListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Compounds'),
      ),
      body: BlocBuilder<CompoundBloc, CompoundState>(
        builder: (context, state) {
          if (state is CompoundLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompoundOperationSuccess) {
            return _buildCompoundList(state.compounds);
          } else if (state is CompoundOperationFailure) {
            return const Center(child: Text('Failed to load compounds'));
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildCompoundList(List<Compound> compounds) {
    return ListView.builder(
      itemCount: compounds.length,
      itemBuilder: (context, index) {
        final compound = compounds[index];
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/park-spot/${compound.id}');
          },
          child: ListTile(
            title: Text(compound.name),
            subtitle: Text(
                'Price: \$${compound.totalSpots.toStringAsFixed(2)} | name: ${compound.name}'),
          ),
        );
      },
    );
  }
}
