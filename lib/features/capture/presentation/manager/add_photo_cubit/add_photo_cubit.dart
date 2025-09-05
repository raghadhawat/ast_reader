import 'dart:developer';

import 'package:ast_reader/features/capture/data/models/add_photo_model.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_photo_state.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  AddPhotoCubit(this.captureRepo) : super(AddPhotoInitial());
  final CaptureRepo captureRepo;
  Future<void> addPhotoCubitFun({required dynamic image}) async {
    emit(AddPhotoLoading());
    var result = await captureRepo.addPhoto(image: image);
    result.fold((failure) {
      log(failure.errMessage);
      emit(AddPhotoFailure(errMessage: failure.errMessage));
    }, (addPhotoModel) async {
      emit(AddPhotoSuccess(addPhotoModel: addPhotoModel));
    });
  }
}
