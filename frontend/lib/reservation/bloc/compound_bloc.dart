import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/bloc/compound_state.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';

class CompoundBloc extends Bloc<CompoundEvent, CompoundState> {
  final CompoundRepository compoundRepository;

  CompoundBloc({required this.compoundRepository}) : super(CompoundLoading()) {
    on<CompoundLoad>((event, emit) async {
      emit(CompoundLoading());
      try {
        print("trying now");
        final compounds = await compoundRepository.fetchAll();
        print("finished trying");
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
  }
}
