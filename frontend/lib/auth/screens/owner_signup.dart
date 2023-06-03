import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:go_router/go_router.dart';

import '../bloc/states/owner_signup_state.dart';

class OwnerSignupPage extends StatefulWidget {
  const OwnerSignupPage({Key? key}) : super(key: key);
  @override
  _OwnerSignupPageState createState() => _OwnerSignupPageState();
}

class _OwnerSignupPageState extends State<OwnerSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _owner = {};
  String message = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Owner Sign Up'),
        ),
        body: BlocBuilder<CompoundOwnerSignupBloc, CompoundOwnerSignUpState>(
          builder: (context, state) {
            if (state is OwnerSignUpLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OwnerSignUpSucess) {
              return Center(child: Text('Sign Up successful'));
            } else if (state is OwnerSignUpFailure) {
              return Center(child: Text('${state.errorMessage}'));
            }

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
                           key:Key('firstname'),
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
                              _owner['firstName'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                            key: Key('lastname'),
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
                              _owner['lastName'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          key:Key('username'),
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
                            _owner['username'] = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                           key:Key('email'),
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
                              _owner['email'] = value;
                            }),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          key: Key('password'),
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
                            _owner['password'] = value;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            key:Key('signupbutton'),
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                print(_owner);
                                final CompoundOwnerSignUpEvent event =
                                    OwnerSignUp(
                                        owner: CompoundOwner(
                                  email: _owner['email'],
                                  firstName: _owner['firstName'],
                                  lastName: _owner['lastName'],
                                  password: _owner['password'],
                                  username: _owner['username'],
                                ));
                                print(event);
                                BlocProvider.of<CompoundOwnerSignupBloc>(
                                        context)
                                    .add(event);
                                if (state is OwnerSignUpSucess) {
                                  (context).goNamed('home');
                                } else if (state is OwnerSignUpFailure) {
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
