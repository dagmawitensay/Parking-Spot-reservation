import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/signin_bloc.dart';
import 'package:frontend/auth/bloc/events/signin_event.dart';
import 'package:frontend/auth/bloc/states/signin_state.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthRepository authRepository = AuthRepository(UserDataProvider());
  int _selectedIndex = 0;
  var role = '';

  void _onItemTapped(int index) async {
    var role = await authRepository.getRole();
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      print(role);
      if (role == 'owner') {
        (context).goNamed('home');
      } else if (role == 'reserver') {
        (context).goNamed('userCompounList');
      }
    } else if (index == 1) {
      (context).goNamed('profile');
    }
    // Add more conditions for other button indexes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(17), child: Text('User Profile')),
            Container(
                padding: const EdgeInsets.all(17),
                child: ElevatedButton(
                  onPressed: () {
                    SignInEvent event = AccountDelete();
                    BlocProvider.of<SignInBloc>(context).add(event);

                    BlocListener<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is AccountDeleteSuccess) {
                          (context).goNamed('startingPage');
                        } else if (state is AccountDeleteFaliure) {
                          if (role == 'owner') {
                            (context).goNamed('home');
                          } else if (role == 'reserver') {
                            (context).goNamed('userCompounList');
                          }
                        }
                      },
                    );
                  },
                  child: const Text('Delete Account'),
                )),
            Container(
                padding: const EdgeInsets.all(17),
                child: ElevatedButton(
                  onPressed: () {
                    authRepository.deleteToken();
                    (context).goNamed('signin');
                  },
                  child: const Text('Log Out'),
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
