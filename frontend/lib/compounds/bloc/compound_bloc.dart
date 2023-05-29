import 'package:bloc/bloc.dart';

import '../repository/compound_repository.dart';
import './compound_event.dart';
import './compound_state.dart';

class CompoundBloc extends Bloc<CompoundEvent, CompoundState> {
  final CompoundRepository compoundRepository;

  CompoundBloc({required this.compoundRepository}) : super(CompoundLoading()) {
    on<CompoundLoad>((event, emit) async {
      final int userId;
      emit(CompoundLoading());
      try {
        final compounds = await compoundRepository.fetchAll();
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
        // print(error);
      }
    });

    on<CompoundCreate>((event, emit) async {
      try {
        print("here now");
        await compoundRepository.create(event.compound);
        print("here trying to inser");
        final compounds = await compoundRepository.fetchAll();
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });

    on<CompoundUpdate>((event, emit) async {
      try {
        await compoundRepository.update(event.id, event.compound);
        final compounds = await compoundRepository.fetchAll();
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });

    on<CompoundDelete>((event, emit) async {
      try {
        await compoundRepository.delete(event.id);
        final compounds = await compoundRepository.fetchAll();
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });
  }
}
