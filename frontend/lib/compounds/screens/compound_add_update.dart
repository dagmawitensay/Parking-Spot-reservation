import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';

class AddUpdateCompound extends StatefulWidget {
  static const routeName = 'compoundAddUpdate';
  final CompoundArgument args;

  const AddUpdateCompound({Key? key, required this.args}) : super(key: key);

  @override
  _AddUpdateCompoundState createState() => _AddUpdateCompoundState();
}

class _AddUpdateCompoundState extends State<AddUpdateCompound> {
  final _formkey = GlobalKey<FormState>();

  final Map<String, dynamic> _compound = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              '${widget.args.edit ? "Edit Compound" : "Add New Compound"}')),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.compound?.Region : '',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter the region';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Region'),
                    onSaved: (value) {
                      setState(
                        () {
                          _compound['Region'] = value;
                        },
                      );
                    }),
                TextFormField(
                    initialValue: '',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Pease enter wereda';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Wereda'),
                    onSaved: (value) {
                      setState(
                        () {
                          _compound['Wereda'] = value;
                        },
                      );
                    }),
                TextFormField(
                    initialValue:
                        widget.args.edit ? widget.args.compound?.Wereda : '',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter zone';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Zone'),
                    onSaved: (value) {
                      setState(
                        () {
                          _compound['Zone'] = value;
                        },
                      );
                    }),
                // TextFormField(
                //   initialValue: widget.args.edit? widget.args.compound?.City: '',
                //   validator: (value) {
                //     if (value != null && value.isEmpty) {
                //       return 'Please enter city';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(labelText: 'City'),
                //   onSaved: (value) {
                //     setState(
                //       () {
                //         _compound['City'] = value;
                //       },
                //     );
                //   },
                // ),
                TextFormField(
                    initialValue: widget.args.edit
                        ? widget.args.compound?.Kebele.toString()
                        : '',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter kebele';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Kebele'),
                    onSaved: (value) {
                      setState(
                        () {
                          _compound['Kebele'] = value;
                        },
                      );
                    }),
                TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.compound?.SlotPricePerHour.toString()
                      : '',
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter price per slot';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Price Per Slot'),
                  onSaved: (value) {
                    setState(
                      () {
                        _compound['SlotPricePerHour'] = value;
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
                      return 'Please enter total spots';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Total Spots'),
                  onSaved: (value) {
                    setState(
                      () {
                        _compound['totalSpots'] = value;
                      },
                    );
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final form = _formkey.currentState;
                        if (form != null && form.validate()) {
                          form.save();
                          print(_compound);
                          final CompoundEvent event = widget.args.edit
                              ? CompoundUpdate(
                                  widget.args.compound?.id ?? 0,
                                  Compound(
                                      id: widget.args.compound?.id,
                                      ownerId: _compound['ownerId'],
                                      Region: _compound['Region'],
                                      Wereda: _compound['Wereda'],
                                      Zone: _compound['Zone'],
                                      Kebele: _compound['Kebele'],
                                      // City: _compound['City'],
                                      availableSpots:
                                          _compound['availableSpots'],
                                      SlotPricePerHour:
                                          _compound['SlotPricePerHour'],
                                      totalSpots: _compound['totalSpots']))
                              : CompoundCreate(Compound(
                                  id: null,
                                  ownerId: 1,
                                  Region: _compound['Region'],
                                  Wereda: _compound['Wereda'],
                                  Zone: _compound['Zone'],
                                  Kebele: _compound['Kebele'],
                                  // City: _compound['City'],
                                  // availableSpots: _compound['availableSpots'],
                                  availableSpots: 2,
                                  SlotPricePerHour: double.parse(
                                      _compound['SlotPricePerHour']),
                                  // totalSpots: 3
                                  totalSpots:
                                      int.parse(_compound['totalSpots'])));
                          print(event);
                          BlocProvider.of<CompoundBloc>(context).add(event);
                          (context).go('/');
                        }
                      },
                      label: const Text('SAVE'),
                      icon: const Icon(Icons.save),
                    ))
              ],
            ),
          )),
    );
  }
}
