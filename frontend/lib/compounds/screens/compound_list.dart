import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';
import '../bloc/compound_state.dart';

class CompoundList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Compounds')),
      body: BlocBuilder<CompoundBloc, CompoundState>(
        builder: (_, state) {
          if (state is CompoundOperationFailure) {
            return const Text('Could not do compound operation');
          }

          if (state is CompoundOperationSuccess) {
            final compounds = state.compounds;

            return ListView.builder(
                itemCount: compounds.length,
                itemBuilder: (_, idx) => Center(
                      child: ListTile(
                          title: Text(compounds.elementAt(idx).Region),
                          subtitle: Text(compounds
                              .elementAt(idx)
                              .SlotPricePerHour
                              .toString()),
                          onTap: () => (context).go('/details',
                              extra: CompoundArgument(
                                  edit: true,
                                  compound: compounds.elementAt(idx)))),
                    ));
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            return (context)
                .go('/addUpdateCompound', extra: CompoundArgument(edit: false));
          },
          child: const Icon(Icons.add)),
    );
  }
}
