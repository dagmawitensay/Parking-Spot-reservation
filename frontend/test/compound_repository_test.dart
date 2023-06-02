import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/data_provider/compound_data_provider.dart';
import 'package:frontend/models/compound.dart';
import 'package:frontend/data_provider/compound_local_data_provider.dart';
import 'package:frontend/repository/compound_repository.dart';
import 'package:mockito/mockito.dart';

class MockCompoundDataProvider extends Mock implements CompoundDataProvider {}

class MockCompoundLocalDataProvider extends Mock
    implements CompoundLocalDataProvider {}

class MockConnectivityChecker extends Mock implements ConnectivityChecker {}

void main() {
  group('CompoundRepository', () {
    late CompoundDataProvider dataProvider;
    late CompoundLocalDataProvider localDataProvider;
    late ConnectivityChecker connectivityChecker;
    late CompoundRepository repository;

    setUp(() {
      dataProvider = MockCompoundDataProvider();
      localDataProvider = MockCompoundLocalDataProvider();
      connectivityChecker = MockConnectivityChecker();
      repository =
          CompoundRepository(dataProvider, localDataProvider, connectivityChecker);
    });

    test('create - when connected, returns new created Compound', () async {
      final compound = Compound(/* ... */);
      final newCreatedCompound = Compound(/* ... */);

      when(localDataProvider.createCompound(compound))
          .thenAnswer((_) => Future.value(compound));
      when(connectivityChecker.checkNetworkConnectivity())
          .thenAnswer((_) => Future.value(true));
      when(dataProvider.createCompound(compound))
          .thenAnswer((_) => Future.value(newCreatedCompound));
      when(localDataProvider.updatesyncPendingCompound(
              compound.id!, true, 'created'))
          .thenAnswer((_) => Future.value());

      final result = await repository.create(compound);

      verify(localDataProvider.createCompound(compound));
      verify(connectivityChecker.checkNetworkConnectivity());
      verify(dataProvider.createCompound(compound));
      verify(localDataProvider.updatesyncPendingCompound(
          compound.id!, true, 'created'));
      expect(result, equals(newCreatedCompound));
    });

    // Write similar tests for other methods of CompoundRepository

    // ...
  });
}
