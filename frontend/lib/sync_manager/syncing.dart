import 'package:connectivity/connectivity.dart';
// import 'package:frontend/localDatabase/sqflite_database.dart';
import '../compounds/data_provider/compound_local_data_provider.dart';
import '../compounds/models/compound.dart';
import 'package:http/http.dart' as http;

class SyncManager{
  final CompoundLocalDataProvider syncMethods = CompoundLocalDataProvider();
  final Connectivity _connectivity = Connectivity();
  
  bool isConnected = false;

  void syncingManager(){
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {

      if (result == ConnectivityResult.none){
        isConnected = false;
      } else{
        isConnected = true;
      }
     });

        syncCreatedData();
        syncUpdatedData();
        syncDeletedData();
  }

  syncCreatedData() async{
    if (isConnected){
      final List<Compound> unsyncedData = await syncMethods.getCreatedsyncPendingCompound();

      for (Compound data in unsyncedData){
        Map<String, dynamic> payload = data.toMap();

        try {
          http.Response response = await http.post(Uri.parse('http://localhost:3000/parking-compounds'), body: payload);
          if (response.statusCode == 201){
            
            await syncMethods.updatesyncPendingCompound(data.id!, true, 'created');
          } else {

          }
        } catch(error){
          return (error);
        }
      }
    }
  }

  syncUpdatedData() async{
    if (isConnected){
      final List<Compound> unsyncedData = await syncMethods.getUpdatedsyncPendingCompound();
       for (Compound data in unsyncedData){
        var id = data.id;
        Map<String, dynamic> payload = data.toMap();

        try {
          http.Response response = await http.put(Uri.parse('http://localhost:3000/parking-compounds/$id'), body: payload);
          if (response.statusCode == 204){
            
            await syncMethods.updatesyncPendingCompound(data.id!, true, 'updated');
          } else {

          }
        } catch(error){
          throw Exception('Failed to load Compound');
        }
      }
    }
  }


syncDeletedData() async {
  if (isConnected){
      final List<Compound> unsyncedData = await syncMethods.getDeletedsyncPendingCompound();
       for (Compound data in unsyncedData){
        var id = data.id;
        // Map<String, dynamic> payload = data.toMap();
        
        try {
          http.Response response = await http.delete(Uri.parse('http://localhost:3000/parking-compounds/$id'));
          if (response.statusCode == 204){
            
            await syncMethods.updatesyncPendingCompound(data.id!, true, 'deleted');
          } 
        } catch(error){
        throw Exception('Failed to delete compound');
    
        }
      }
    }

}

}



