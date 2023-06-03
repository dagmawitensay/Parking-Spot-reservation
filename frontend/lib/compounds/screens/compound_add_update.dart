import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/authentication_bloc.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/auth/screens/signin.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';

import '../../auth/bloc/events/authentication_event.dart';
import '../../auth/bloc/states/authenticatoin_state.dart';

class AddUpdateCompound extends StatefulWidget {
  static const routeName = 'compoundAddUpdate';
  final CompoundArgument args;

  const AddUpdateCompound({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _AddUpdateCompoundState createState() => _AddUpdateCompoundState();
}

class _AddUpdateCompoundState extends State<AddUpdateCompound> {
  final _formkey = GlobalKey<FormState>();

  final Map<String, dynamic> _compound = {};
  final AuthRepository authRepository = AuthRepository(UserDataProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(onPressed: () => (context).goNamed('home')),
            title:
                Text(widget.args.edit ? "Edit Compound" : "Add New Compound")),
        body: BlocProvider(
          create: (context) =>
              AuthenticationBloc(authRepository: authRepository)
                ..add(AppStarted()),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              (context).goNamed('signin');
              return Container();
            } else {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
                  child: Form(
                    key: _formkey,
                    child: ListView(
                      children: [
                        TextFormField(
                          key: Key('Name'),
                            initialValue: widget.args.edit
                                ? widget.args.compound?.name
                                : '',
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            onSaved: (value) {
                              setState(
                                () {
                                  _compound['name'] = value;
                                },
                              );
                            }),
                        TextFormField(
                           key: Key('Region'),
                            initialValue: widget.args.edit
                                ? widget.args.compound?.Region
                                : '',
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter the region';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Region'),
                            onSaved: (value) {
                              setState(
                                () {
                                  _compound['Region'] = value;
                                },
                              );
                            }),
                        TextFormField(
                           key: Key("Wereda"),
                            initialValue: widget.args.edit
                                ? widget.args.compound?.Wereda
                                : '',
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Pease enter wereda';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Wereda'),
                            onSaved: (value) {
                              setState(
                                () {
                                  _compound['Wereda'] = value;
                                },
                              );
                            }),
                        TextFormField(
                          key: Key('Zone'),
                            initialValue: widget.args.edit
                                ? widget.args.compound?.Wereda
                                : '',
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'please enter zone';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Zone'),
                            onSaved: (value) {
                              setState(
                                () {
                                  _compound['Zone'] = value;
                                },
                              );
                            }),
                        TextFormField(
                           key: Key('Price per slot'),
                            initialValue: widget.args.edit
                                ? widget.args.compound?.Kebele.toString()
                                : '',
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter kebele';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Kebele'),
                            onSaved: (value) {
                              setState(
                                () {
                                  _compound['Kebele'] = value;
                                },
                              );
                            }),
                        TextFormField(
                          key: Key('Total  Spots'),
                          initialValue: widget.args.edit
                              ? widget.args.compound?.SlotPricePerHour
                                  .toString()
                              : '',
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter price per slot';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Price Per Slot'),
                          onSaved: (value) {
                            setState(
                              () {
                                _compound['SlotPricePerHour'] = value;
                              },
                            );
                          },
                        ),
                        TextFormField(
                          key:Key('Available Spots'),
                          initialValue: widget.args.edit
                              ? widget.args.compound?.totalSpots.toString()
                              : '',
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter total spots';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Total Spots'),
                          onSaved: (value) {
                            setState(
                              () {
                                _compound['totalSpots'] = value;
                              },
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: widget.args.edit
                              ? widget.args.compound?.totalSpots.toString()
                              : '',
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter avialable spots';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Available Spots'),
                          onSaved: (value) {
                            setState(
                              () {
                                _compound['availableSpots'] = value;
                              },
                            );
                          },
                        ),
                        ElevatedButton(
                            key: Key('savecompound'),
                            onPressed: () async {},
                            child: const Text('Pick Compound Image')),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                final form = _formkey.currentState;
                                if (form != null && form.validate()) {
                                  form.save();
                                  final CompoundEvent event = widget.args.edit
                                      ? CompoundUpdate(Compound(
                                          id: widget.args.compound?.id,
                                          // ownerId: _compound['ownerId'],
                                          ownerId: 1,
                                          name: _compound['name'],
                                          Region: _compound['Region'],
                                          Wereda: _compound['Wereda'],
                                          Zone: _compound['Zone'],
                                          Kebele: _compound['Kebele'],
                                          // City: _compound['City'],
                                          // availableSpots:
                                          //     _compound['availableSpots'],
                                          availableSpots: int.parse(
                                              _compound['availableSpots']),
                                          SlotPricePerHour: double.parse(
                                              _compound['SlotPricePerHour']),
                                          totalSpots: int.parse(
                                              _compound['totalSpots'])))
                                      : CompoundCreate(Compound(
                                          id: null,
                                          ownerId: 1,
                                          name: _compound['name'],
                                          Region: _compound['Region'],
                                          Wereda: _compound['Wereda'],
                                          Zone: _compound['Zone'],
                                          Kebele: _compound['Kebele'],
                                          // City: _compound['City'],
                                          // availableSpots: _compound['availableSpots'],
                                          availableSpots: int.parse(
                                              _compound['availableSpots']),
                                          SlotPricePerHour: double.parse(
                                              _compound['SlotPricePerHour']),
                                          // totalSpots: 3
                                          totalSpots: int.parse(
                                              _compound['totalSpots'])));
                                  BlocProvider.of<CompoundBloc>(context)
                                      .add(event);
                                  (context).go('/compoundList');
                                }
                              },
                              label: const Text('SAVE'),
                              icon: const Icon(Icons.save),
                            ))
                      ],
                    ),
                  ));
            }
          // }),
  })
        ));
  }
}
