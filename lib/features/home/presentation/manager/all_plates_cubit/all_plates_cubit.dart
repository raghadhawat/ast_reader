import 'package:ast_reader/features/home/data/models/all_plates_model/all_plates_model.dart';
import 'package:ast_reader/features/home/data/repos/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_plates_state.dart';
class AllPlatesCubit extends Cubit<AllPlatesState> {
  AllPlatesCubit(this.homeRepo) : super(AllPlatesInitial());
  final HomeRepo homeRepo;

  int _reqCounter = 0; // prevents race conditions

  Future<void> getAllPlatesCubitFunction({
    String? search,
    String? status,
    String? firstName,
    String? lastName,
    String? startDate,
    String? endDate,
    int? userId,
  }) async {
    if (isClosed) return;

    // mark this invocation
    final int myReq = ++_reqCounter;

    emit(AllPlatesLoading());

    final result = await homeRepo.getAllPlates(
      search: search,
      status: status,
      firstName: firstName,
      lastName: lastName,
      startDate: startDate,
      endDate: endDate,
    );

    // if another call started after this one, drop this response
    if (isClosed || myReq != _reqCounter) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AllPlatesFailure(errMessage: failure.errMessage));
      },
      (allPlatesModel) {
        if (isClosed) return;
        emit(AllPlatesSuccess(allPlatesModel: allPlatesModel));
      },
    );
  }

  @override
  Future<void> close() {
    _reqCounter++; // invalidate any in-flight requests
    return super.close();
  }
}
