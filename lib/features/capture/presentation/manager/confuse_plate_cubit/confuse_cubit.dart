import 'package:ast_reader/features/capture/data/models/status_model.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'confuse_state.dart';

class ConfuseCubit extends Cubit<ConfuseState> {
  ConfuseCubit(this.captureRepo) : super(ConfuseInitial());
   final CaptureRepo captureRepo;
  Future<void> confusePlateCubitFun({required int plateId}) async {
    emit(ConfuseLoading());
    var result = await captureRepo.confusePlate(plateId: plateId);
    result.fold((failure) {
      emit(ConfuseFailure(errMessage: failure.errMessage));
    }, (statusModel) async {
      emit(ConfuseSuccess(statusModel: statusModel));
    });
  }
}
