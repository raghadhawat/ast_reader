import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/all_plates_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure,AllPlatesModel>> getAllPlates({
  String? search,
  String? status,
  String? firstName,   // NOTE: Swagger shows "fistName" (typo). Backend expects "fistName".
  String? lastName,
  String? startDate,   // e.g. "2025-09-01" or ISO string per backend
  String? endDate,     // e.g. "2025-09-05"
  int? userId,
});
}