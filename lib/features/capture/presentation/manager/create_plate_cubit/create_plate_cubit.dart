import 'dart:developer';

import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_plate_state.dart';

class CreatePlateCubit extends Cubit<CreatePlateState> {
  CreatePlateCubit(this.captureRepo) : super(CreatePlateInitial());
  final CaptureRepo captureRepo;
  Future<void> createPlateCubitFun(
      {required String firstName,
      required String lastName,
      required String number,
      required String notes,
      required int imageId}) async {
    emit(CreatePlateLoading());
    var result = await captureRepo.createPlate(
        firstName: firstName,
        lastName: lastName,
        number: number,
        notes: notes,
        imageId: imageId);

    result.fold((failure) {
      emit(CreatePlateFailure(errMessage: failure.errMessage));
    }, (data) async {
      emit(CreatePlateSuccess(data: data));
    });
  }
}
