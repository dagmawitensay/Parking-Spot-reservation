import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/compound_state.dart';

class CompoundList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Compounds')),
      body: BlocBuilder<CompoundBloc, CompoundState>(
        builder: (_, state) {
          if (state is CompoundOperationFailure) {
            return const Text('Could not do compound operation');
          }

          if (state is CompoundOperationSuccess) {
            final compounds = state.compounds;

            return ListView.builder(
              itemCount: compounds.length,
              itemBuilder: (_, idx) => ListTile(
                  title: Text(compounds.elementAt(idx).Region),
                  subtitle: Text(
                      compounds.elementAt(idx).SlotPricePerHour.toString()),
                  onTap: () => (context).go('./details')),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => (context).go('./addUpdateCompound'),
          child: const Icon(Icons.add)),
    );
  }
}
// class compoundList extends StatelessWidget {
//   static const routeName = '/';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('List of compounds'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               buildCard('Dembel city parking', 'Bole Alemgena', '1000', '10',
//                   'https://media.istockphoto.com/id/471637311/nl/foto/drive-in-milky-way.jpg?s=2048x2048&w=is&k=20&c=AxwO0kCHF3n9Dm7pMFiC3LyeCi24ygKHtoUTaq8TDx0='),
//               buildCard('22 Mazoria', '22', '1200', '20',
//                   'https://media.istockphoto.com/id/471637311/nl/foto/drive-in-milky-way.jpg?s=2048x2048&w=is&k=20&c=AxwO0kCHF3n9Dm7pMFiC3LyeCi24ygKHtoUTaq8TDx0='),
//             ],
//           ),
//         ));
//   }

//   Widget buildCard(String name, String location, String pricePerSlot,
//       String totalSpots, String imageUrl) {
//     return Card(
//       child: Container(
//         height: 150, // Specify a fixed height for the Card
//         padding: const EdgeInsets.all(4.0),
//         child: Column(
//           children: [
//             Expanded(child: Image.network(imageUrl)),
//             Spacer(flex: 1),
//             Text(name),
//             Text(location),
//             Row(
//               children: [
//                 Text(pricePerSlot),
//                 Text(totalSpots),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
