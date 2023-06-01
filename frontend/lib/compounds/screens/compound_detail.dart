import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:go_router/go_router.dart';

import '../models/compound.dart';
import 'compound_route.dart';

class CompoundDetail extends StatelessWidget {
  final Compound compound;

  const CompoundDetail({Key? key, required this.compound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(compound.Region),
          leading: BackButton(onPressed: () => (context).goNamed('home')),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                return (context).go('/addUpdateCompound',
                    extra: CompoundArgument(compound: compound, edit: true));
              },
            ),
            const SizedBox(
              width: 32,
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<CompoundBloc>(context)
                      .add(CompoundDelete(compound.id ?? 0));
                  return (context).goNamed('home');
                })
          ]),
      body: Card(
          child: Column(
        children: [
          ListTile(
            title: Text('Name: ${compound.name}'),
            subtitle: Text('SpotPricePerHour: ${compound.SlotPricePerHour}'),
          ),
          const Text('Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Region: ${compound.Region}'),
          Text('Wereda: ${compound.Wereda}'),
          Text('Zone: ${compound.Zone}'),
          Text('Kebele: ${compound.Kebele}'),
          Text('Total spots: ${compound.totalSpots}')
        ],
      )),
    );
  }
}
