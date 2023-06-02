import '../../localDatabase/connectivity_checking.dart';
import '../data_provider/compound_data_provider.dart';
import '../models/compound.dart';
import '../data_provider/compound_local_data_provider.dart';

class CompoundRepository {
  final CompoundDataProvider dataProvider;
  final CompoundLocalDataProvider localDataProvider;
  final ConnectivityChecks connectivitychecker;

  CompoundRepository(
      this.dataProvider, this.localDataProvider, this.connectivitychecker);

  Future<Compound> create(Compound compound) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();

    if (isConnected) {
      final newCreatedCompound = await dataProvider.createCompound(compound);
      return newCreatedCompound;
    } else {
      final localCreateddata = await localDataProvider.createCompound(compound);
      // await localDataProvider.updatesyncPendingCompound(
      //     compound.id!, true, 'created');
      return localCreateddata;
    }
  }

  Future<Compound> get(int id) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    if (isConnected) {
      return dataProvider.getCompound(id);
    } else {
      return localDataProvider.getCompound(id);
    }
  }

  Future<List<Compound>> fetchAll() async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    if (isConnected) {
      final fromRemote = await dataProvider.fetchAll();
      return fromRemote;
    } else {
      final compounds = await localDataProvider.getCompounds();
      return compounds;
    }
  }

  Future<Compound> update(Compound compound) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    if (isConnected) {
      return dataProvider.updateCompound(compound);
    } else {
      localDataProvider.updatesyncPendingCompound(
          compound.id!, true, 'updated');
      return localDataProvider.updateCompound(compound);
    }
  }

  Future<void> delete(int id) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();
    if (isConnected) {
      dataProvider.deleteCompound(id);
    } else {
      // await localDataProvider.deleteCompoundStatus(id);
      await localDataProvider.updatesyncPendingCompound(id, true, 'deleted');
      localDataProvider.deleteCompound(id);
    }
  }

  Future<List<Compound>> fetchAllOwner(int ownerId) async {
    final isConnected = await connectivitychecker.checkNetworkConnectivity();

    if (isConnected) {
      return await dataProvider.fetchAllOwner(ownerId);
    } else {
      return await localDataProvider.getCompoundsOfOwner(ownerId);
    }
  }

  Future<List<Compound>> fetchCompound(int userId) {
    return dataProvider.fetchCompounds(userId);
  }
}
