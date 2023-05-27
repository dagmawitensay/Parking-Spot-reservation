import '../data_provider/compound_data_provider.dart';
import '../models/compound.dart';

class CompoundRepository {
  final CompoundDataProvider dataProvider;

  CompoundRepository(this.dataProvider);

  Future<Compound> create(Compound compound) async {
    return this.dataProvider.createCompound(compound);
  }

  Future<Compound> get(int id) {
    return this.dataProvider.getCompound(id);
  }

  Future<List<Compound>> fetchAll() {
    return this.dataProvider.fetchAll();
  }

  Future<void> update(int id, Compound compound) async {
    this.dataProvider.updateCompound(id, compound);
  }

  Future<void> delete(int id) async {
    this.dataProvider.deleteCompound(id);
  }

  Future<List<Compound>> fetchCompound(int userId) {
    return this.dataProvider.fetchCompounds(userId);
  }
}
