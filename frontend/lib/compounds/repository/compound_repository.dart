import '../../localDatabase/connectivity_checking.dart';
import '../data_provider/compound_data_provider.dart';
import '../models/compound.dart';
import '../data_provider/compound_local_data_provider.dart';


class CompoundRepository {
  final CompoundDataProvider dataProvider;
  final CompoundLocalDataProvider localDataProvider;
  final ConnectivityChecks  connectivitychecker;

  CompoundRepository(this.dataProvider,this.localDataProvider,this.connectivitychecker);
 
  Future<Compound> create(Compound compound) async {
     final localCreateddata = await localDataProvider.createCompound(compound);
     final isConnected = await connectivitychecker.checkNetworkConnectivity();

     if (isConnected){
       final newCreatedCompound = await dataProvider.createCompound(compound);
       await localDataProvider.updatesyncPendingCompound(compound.id!,true,'created');
       return newCreatedCompound;
       
     } else {
       localDataProvider.updatesyncPendingCompound(compound.id!,false,null);
       return localCreateddata;
     }   
  }

  Future<Compound> get(int id) {
    // final isConnected = await connectivitychecker.checkNetworkConnectivity();
    // if (isConnected){
      
    // }
    return this.dataProvider.getCompound(id);
  }

  Future<List<Compound>> fetchAll() async{
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    final compounds = await localDataProvider.getCompounds();

    if (isConnected){
      final fromRemote = await dataProvider.fetchAll();
      return fromRemote;
    }else{
      return compounds;
    }

 
  }

  Future<void> update(int id, Compound compound) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    if (isConnected){
      dataProvider.updateCompound(id, compound);
    } else{
      localDataProvider.updateCompound(compound);
      localDataProvider.updatesyncPendingCompound(id,true,'updated');
    }
  }

  Future<void> delete(int id) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    // await localDataProvider.deleteCompoundStatus(id);
    await localDataProvider.updatesyncPendingCompound(id, true,'deleted');
    if (isConnected){
      dataProvider.deleteCompound(id);
      localDataProvider.deleteCompound(id);
    }

  }

  Future<List<Compound>> fetchCompound(int userId) {
    return this.dataProvider.fetchCompounds(userId);
  }
}
