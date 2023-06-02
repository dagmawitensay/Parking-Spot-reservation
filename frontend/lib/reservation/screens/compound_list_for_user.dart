import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/reservation/screens/routes.dart';
import 'package:go_router/go_router.dart';
import '../../compounds/bloc/compound_state.dart';

class CompoundListForUser extends StatelessWidget {
  const CompoundListForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of Compounds')),
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
                      title: Text(compounds.elementAt(idx).name),
                      subtitle: Text(
                          compounds.elementAt(idx).SlotPricePerHour.toString()),
                      // onTap: () {},
                      onTap: () => (context).goNamed('timerpage',
                          extra: compounds.elementAt(idx).id),
                    )));
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