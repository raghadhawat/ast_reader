import 'package:ast_reader/features/capture/data/models/status_model.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reject_plate_state.dart';

class RejectPlateCubit extends Cubit<RejectPlateState> {
  RejectPlateCubit(this.captureRepo) : super(RejectPlateInitial());
  final CaptureRepo captureRepo;
  Future<void> rejectPlateCubitFun({required int plateId}) async {
    emit(RejectPlateLoading());
    var result = await captureRepo.rejectPlate(plateId: plateId);
    result.fold((failure) {
      emit(RejectPlateFailure(errMessage: failure.errMessage));
    }, (statusModel) async {
      emit(RejectPlateSuccess(statusModel: statusModel));
    });
  }
}
