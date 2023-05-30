import 'package:sqflite/sqflite.dart';
import '../../localDatabase/sqflite_database.dart';
import '../models/compound.dart';

class CompoundLocalDataProvider {
final  local = LocalDatabaseProvider();

Future<Compound> createCompound(Compound compoundData) async{
  final localdatabase =  await local.database;

  await localdatabase!.insert(
  'parking_compound',
  compoundData.toMap(),
  conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return Compound.fromJson(compoundData.toMap());
  
}

Future<List<Compound>> getCompounds(Compound compoundData) async{
  final localdatabase = await local.database;

  List<Map<String,dynamic>> maps = await  localdatabase!.query('parking_compound');

  return List.generate(maps.length, (index){
    return Compound.fromJson(maps[index]);
  });

}

Future<void> updateCompound( Compound data) async{
  final localdatabase = await local.database;

  await localdatabase?.update(
    'parking_compound',
    data.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    where: 'id = ?',
    whereArgs: [data.id]
  );
}

Future<void> deleteCompound(int id) async{

  final localdatabase = await local.database;

  await localdatabase!.delete(
    'parking_compound',
    where: 'id = ?',
    whereArgs: [id]
  );
}
}