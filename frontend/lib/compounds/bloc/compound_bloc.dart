import 'package:bloc/bloc.dart';

import '../repository/compound_repository.dart';
import './compound_event.dart';
import './compound_state.dart';

class CompoundBloc extends Bloc<CompoundEvent, CompoundState> {
  final CompoundRepository compoundRepository;

  CompoundBloc({required this.compoundRepository}) : super(CompoundLoading()) {
    print("startint to listen events");
    on<CompoundLoad>((event, emit) async {
      emit(CompoundLoading());
      try {
        print("trying now");
        final compounds = await compoundRepository.fetchAll();

        print("finished trying");
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        print(error);
        emit(CompoundOperationFailure(error));
        // print(error);
      }
    });

    on<CompoundCreate>((event, emit) async {
      try {
        print("here now");
        final compound = await compoundRepository.create(event.compound);
        print("here trying to inser");
        final compounds = await compoundRepository.fetchAll();
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });

    on<CompoundUpdate>((event, emit) async {
      try {
        print("here to update");
        await compoundRepository.update(event.compound);
        print("after update");
        final compounds = await compoundRepository.fetchAll();
        print(compounds);
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });

    on<CompoundDelete>((event, emit) async {
      try {
        print('trying to delete compound');
        await compoundRepository.delete(event.id);
        print("after deleting compound");
        final compounds = await compoundRepository.fetchAll();
        emit(CompoundOperationSuccess(compounds));
      } catch (error) {
        emit(CompoundOperationFailure(error));
      }
    });
  }
}
