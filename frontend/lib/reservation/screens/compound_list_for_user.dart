import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';

import '../../compounds/bloc/compound_state.dart';

class CompoundListForUser extends StatefulWidget {
  const CompoundListForUser({Key? key}) : super(key: key);

  @override
  _CompoundListForUserState createState() => _CompoundListForUserState();
}

class _CompoundListForUserState extends State<CompoundListForUser> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      (context).goNamed('userCompounList');
    } else if (index == 1) {
      (context).goNamed('profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Compounds'),
      ),
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
                      onTap: () {
                        (context).goNamed('timerPage', queryParameters: {
                          'compound_id': [
                            compounds.elementAt(idx).id.toString()
                          ]
                        });
                      },
                    )));
          }

          return const CircularProgressIndicator();
        },
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

























// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/compounds/bloc/compound_bloc.dart';
// import 'package:frontend/compounds/screens/compound_route.dart';
// import 'package:go_router/go_router.dart';

// import '../../compounds/bloc/compound_state.dart';

// class CompoundListForUser extends StatelessWidget {
//   const CompoundListForUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('List of Compounds')),
//         body: BlocBuilder<CompoundBloc, CompoundState>(
//           builder: (_, state) {
//             if (state is CompoundOperationFailure) {
//               return const Text('Could not do compound operation');
//             }

//             if (state is CompoundOperationSuccess) {
//               final compounds = state.compounds;

//               return ListView.builder(
//                   itemCount: compounds.length,
//                   itemBuilder: (_, idx) => Center(
//                         child: ListTile(
//                           title: Text(compounds.elementAt(idx).name),
//                           subtitle: Text(compounds
//                               .elementAt(idx)
//                               .SlotPricePerHour
//                               .toString()),
//                           onTap: () {
//                             (context).goNamed('timerPage', queryParameters: {
//                               'compound_id': [
//                                 compounds.elementAt(idx).id.toString()
//                               ]
//                             });
//                           },
//                         ),
//                       ));
//             }

//             return const CircularProgressIndicator();
//           },
//         )
//         );
//   }
// }
