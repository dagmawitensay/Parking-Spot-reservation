import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/signin_bloc.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:go_router/go_router.dart';

import '../bloc/events/signin_event.dart';
import '../bloc/states/signin_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var incorrectMessage = '';
  var incorrectCredentials = false;

  final Map<String, dynamic> _user = {};
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
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
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                       key: Key('signinemail'),
                        controller: _emailController,
                        decoration: InputDecoration(
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
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: const Icon(Icons.check_circle,
                              color: Colors.green),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2.0),
                          ),
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _user['email'] = value;
                        }),
                    const SizedBox(height: 16.0),
                    TextFormField(
                        key: Key('signinpassword'),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'enter your password',
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
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _user['password'] = value;
                        }),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          shadowColor: Colors.black.withOpacity(0.2),
                          elevation: 8.0,
                        ),
                        child: const Text('Login'),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            final SignInEvent event = SignIn(
                                user: User(
                              email: _user['email'],
                              password: _user['password'],
                            ));
                            print(_user.values);
                            BlocProvider.of<SignInBloc>(context).add(event);
                            if (state is SignInFailure) {
                              setState(() {
                                incorrectCredentials = true;
                                incorrectMessage = 'Invalid email or password';
                              });
                            }
                            if (state is SignInSucess) {
                              if (state.user.role == 'owner') {
                                (context).goNamed('compoundList');
                              } else if (state.user.role == 'reserver') {
                                (context).goNamed('userCompounList');
                              }
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(incorrectMessage,
                          style: const TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        // Forgot password logic here
                      },
                      child: const Text("Forgot password?"),
                    )),
                    const SizedBox(height: 16.0),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        (context).goNamed('startingPage');
                      },
                      child: const Text("Don't have an account? Sign up"),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
