import 'package:ast_reader/features/home/data/models/all_plates_model/all_plates_model.dart';
import 'package:ast_reader/features/home/data/repos/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_plates_state.dart';

class AllPlatesCubit extends Cubit<AllPlatesState> {
  AllPlatesCubit(this.homeRepo) : super(AllPlatesInitial());
  final HomeRepo homeRepo;
  Future<void> getAllPlatesCubitFunction({
    String? search,
    String? status,
    String?
        firstName, // NOTE: Swagger shows "fistName" (typo). Backend expects "fistName".
    String? lastName,
    String? startDate, // e.g. "2025-09-01" or ISO string per backend
    String? endDate, // e.g. "2025-09-05"
    int? userId,
  }) async {
    emit(AllPlatesLoading());
    var result = await homeRepo.getAllPlates(
        search: search,
        status: status,
        firstName: firstName,
        lastName: lastName,
        startDate: startDate,
        endDate: endDate);
    result.fold((failure) {
      emit(AllPlatesFailure(errMessage: failure.errMessage));
    }, (allPlatesModel) async {
      emit(AllPlatesSuccess(allPlatesModel: allPlatesModel));
    });
  }
}
