import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/features/capture/data/models/add_photo_model.dart';
import 'package:ast_reader/features/capture/data/models/status_model.dart';
import 'package:dartz/dartz.dart';

abstract class CaptureRepo {
  Future<Either<Failure, AddPhotoModel>> addPhoto({required dynamic image});
  Future<Either<Failure, StatusModel>> rejectPlate({required int plateId});
  Future<Either<Failure, StatusModel>> acceptPlate({required int plateId});
  Future<Either<Failure, StatusModel>> confusePlate({required int plateId});
}
