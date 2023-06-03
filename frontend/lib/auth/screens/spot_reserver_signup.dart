import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/blocs/signin_bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/states/spot_reserver_signup_event.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:go_router/go_router.dart';

import '../bloc/blocs/spot_reserver_signup_bloc.dart';
import '../bloc/events/spot_reserver_signup_event.dart';
import '../bloc/states/signin_state.dart';

class SpotReserverSignupPage extends StatefulWidget {
  const SpotReserverSignupPage({Key? key}) : super(key: key);
  @override
  _SpotReserverSignupPageState createState() => _SpotReserverSignupPageState();
}

class _SpotReserverSignupPageState extends State<SpotReserverSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _reserver = {};
  String message = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: BlocBuilder<ReserverSignupBloc, SpotReserverSignupState>(
          builder: (context, state) {
            return Center(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              prefixIcon: const Icon(Icons.person),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _reserver['firstName'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              prefixIcon: const Icon(Icons.person),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _reserver['lastName'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            prefixIcon: const Icon(Icons.person),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _reserver['username'] = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'example@gmail.com',
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              prefixIcon: const Icon(Icons.mail),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _reserver['email'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: const Icon(Icons.visibility),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _reserver['password'] = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                print(_reserver);
                                final ReserverSignUpEvent event =
                                    ReserverSignUp(
                                        reserver: SpotReservingUser(
                                  email: _reserver['email'],
                                  firstName: _reserver['firstName'],
                                  lastName: _reserver['lastName'],
                                  password: _reserver['password'],
                                  username: _reserver['username'],
                                ));
                                BlocProvider.of<ReserverSignupBloc>(context)
                                    .add(event);
                                print("current state now");
                                print(state);
                                if (state is ReserverSignUpSucess) {
                                  (context).goNamed('userCompounList');
                                } else if (state is ReserverSignUpFailure) {
                                  print(state.errorMessage ==
                                      'Exception: Credentials taken');
                                  setState(() {
                                    if (state.errorMessage ==
                                        'Exception: Credentials taken') {
                                      message = 'Credentials taken';
                                    }
                                  });
                                }
                              }
                            },
                            child: const Text('Sign Up'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: Text(message,
                              style: TextStyle(color: Colors.red)),
                        ),
                        Center(
                            child: TextButton(
                          onPressed: () {
                            (context).goNamed('signin');
                          },
                          child: const Text('Already have an account? Login'),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login and Signup',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SpotReserverSignupPage());
  }
}
