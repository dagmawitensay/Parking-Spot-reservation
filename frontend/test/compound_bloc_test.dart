import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compound/bloc/compound_bloc.dart';
import 'package:frontend/compound/models/compound.dart';
import 'package:frontend/compound/repository/compound_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCompoundRepository extends Mock implements CompoundRepository {}

void main() {
  late CompoundRepository compoundRepository;
  late CompoundBloc compoundBloc;

  setUp(() {
    compoundRepository = MockCompoundRepository();
    compoundBloc = CompoundBloc(compoundRepository: compoundRepository);
  });

  tearDown(() {
    compoundBloc.close();
  });

  group('CompoundBloc', () {
    final compound1 = Compound(id: 1, name: 'Compound 1');
    final compound2 = Compound(id: 2, name: 'Compound 2');
    final compoundList = [compound1, compound2];

    test('initial state should be CompoundLoading', () {
      expect(compoundBloc.state, CompoundLoading());
    });

    blocTest<CompoundBloc, CompoundState>(
      'emits [CompoundLoading, CompoundOperationSuccess] when CompoundLoad event is added',
      build: () {
        when(() => compoundRepository.fetchAll())
            .thenAnswer((_) async => compoundList);
        return compoundBloc;
      },
      act: (bloc) => bloc.add(CompoundLoad()),
      expect: () => [
        CompoundLoading(),
        CompoundOperationSuccess(compoundList),
      ],
    );

    blocTest<CompoundBloc, CompoundState>(
      'emits [CompoundOperationSuccess] when CompoundCreate event is added',
      build: () {
        when(() => compoundRepository.create(compound1))
            .thenAnswer((_) async => compound1);
        when(() => compoundRepository.fetchAll())
            .thenAnswer((_) async => compoundList);
        return compoundBloc;
      },
      act: (bloc) => bloc.add(CompoundCreate(compound: compound1)),
      expect: () => [
        CompoundOperationSuccess(compoundList),
      ],
    );

    blocTest<CompoundBloc, CompoundState>(
      'emits [CompoundOperationSuccess] when CompoundUpdate event is added',
      build: () {
        when(() => compoundRepository.update(compound1))
            .thenAnswer((_) async {});
        when(() => compoundRepository.fetchAll())
            .thenAnswer((_) async => compoundList);
        return compoundBloc;
      },
      act: (bloc) => bloc.add(CompoundUpdate(compound: compound1)),
      expect: () => [
        CompoundOperationSuccess(compoundList),
      ],
    );

    blocTest<CompoundBloc, CompoundState>(
      'emits [CompoundOperationSuccess] when CompoundDelete event is added',
      build: () {
        when(() => compoundRepository.delete(compound1.id))
            .thenAnswer((_) async {});
        when(() => compoundRepository.fetchAll())
            .thenAnswer((_) async => compoundList);
        return compoundBloc;
      },
      act: (bloc) => bloc.add(CompoundDelete(id: compound1.id)),
      expect: () => [
        CompoundOperationSuccess(compoundList),
      ],
    );

    blocTest<CompoundBloc, CompoundState>(
      'emits [CompoundOperationFailure] when an error occurs',
      build: () {
        when(() => compoundRepository.fetchAll()).thenThrow(Exception('Error'));
        return compoundBloc;
      },
      act: (bloc) => bloc.add(CompoundLoad()),
      expect: () => [
        CompoundLoading(),
        CompoundOperationFailure(Exception('Error')),
      ],
    );
  });
}
