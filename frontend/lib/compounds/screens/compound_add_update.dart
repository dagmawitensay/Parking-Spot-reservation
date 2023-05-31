import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
                        widget.args.edit ? widget.args.compound?.Wereda : '',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'please enter name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Name'),
                    onSaved: (value) {
                      setState(
                        () {
                          _compound['name'] = value;
                        },
                      );
                    }),
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
                  decoration:
                      const InputDecoration(labelText: 'Availbable Spots'),
                  onSaved: (value) {
                    setState(
                      () {
                        _compound['availableSpots'] = value;
                      },
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () async {}, child: Text('Pick Compound Image')),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final form = _formkey.currentState;
                        if (form != null && form.validate()) {
                          form.save();
                          print(widget.args.compound?.id);
                          final CompoundEvent event = widget.args.edit
                              ? CompoundUpdate(Compound(
                                  id: widget.args.compound?.id,
                                  // ownerId: _compound['ownerId'],
                                  ownerId: 1,
                                  // name: _compound['name'],
                                  Region: _compound['Region'],
                                  Wereda: _compound['Wereda'],
                                  Zone: _compound['Zone'],
                                  Kebele: _compound['Kebele'],
                                  // City: _compound['City'],
                                  // availableSpots:
                                  //     _compound['availableSpots'],
                                  availableSpots:
                                      int.parse(_compound['availableSpots']),
                                  SlotPricePerHour: double.parse(
                                      _compound['SlotPricePerHour']),
                                  totalSpots:
                                      int.parse(_compound['totalSpots'])))
                              : CompoundCreate(Compound(
                                  id: null,
                                  ownerId: 1,
                                  // name: _compound['name'],
                                  Region: _compound['Region'],
                                  Wereda: _compound['Wereda'],
                                  Zone: _compound['Zone'],
                                  Kebele: _compound['Kebele'],
                                  // City: _compound['City'],
                                  // availableSpots: _compound['availableSpots'],
                                  availableSpots:
                                      int.parse(_compound['availableSpots']),
                                  SlotPricePerHour: double.parse(
                                      _compound['SlotPricePerHour']),
                                  // totalSpots: 3
                                  totalSpots:
                                      int.parse(_compound['totalSpots'])));
                          BlocProvider.of<CompoundBloc>(context).add(event);
                          (context).go('/compoundList');
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
