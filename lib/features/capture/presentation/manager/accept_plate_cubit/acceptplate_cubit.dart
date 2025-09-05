import 'package:ast_reader/features/capture/data/models/status_model.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'acceptplate_state.dart';

class AcceptplateCubit extends Cubit<AcceptplateState> {
  AcceptplateCubit(this.captureRepo) : super(AcceptplateInitial());
  final CaptureRepo captureRepo;
  Future<void> acceptPlateCubitFun({required int plateId}) async {
    emit(AcceptplateLoading());
    var result = await captureRepo.acceptPlate(plateId: plateId);
    result.fold((failure) {
      emit(AcceptplateFailure(errMessage: failure.errMessage));
    }, (statusModel) async {
      emit(AcceptplateSuccess(statusModel: statusModel));
    });
  }
}
