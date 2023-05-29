import '../data_provider/compound_data_provider.dart';
import '../models/compound.dart';

class CompoundRepository {
  final CompoundDataProvider dataProvider;

  CompoundRepository(this.dataProvider);

  Future<Compound> create(Compound compound) async {
    return await this.dataProvider.createCompound(compound);
  }

  Future<Compound> get(int id) async {
    return await this.dataProvider.getCompound(id);
  }

  Future<List<Compound>> fetchAll() async {
    return await this.dataProvider.fetchAll();
  }

  Future<List<Compound>> fetchAllOwner(int ownerId) async {
    return await this.dataProvider.fetchAllOwner(ownerId);
  }

  Future<Compound> update(Compound compound) async {
    return await this.dataProvider.updateCompound(compound);
  }

  Future<void> delete(int id) async {
    return await this.dataProvider.deleteCompound(id);
  }

  Future<List<Compound>> fetchCompound(int userId) {
    return this.dataProvider.fetchCompounds(userId);
  }
}
