import 'dart:developer';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/core/utils/api_server.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/all_plates_model.dart';
import 'package:ast_reader/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiServer apiServer;

  HomeRepoImpl(this.apiServer);
  @override
  Future<Either<Failure, AllPlatesModel>> getAllPlates({
    String? search,
    String? status,
    String?
        firstName, // NOTE: Swagger shows "fistName" (typo). Backend expects "fistName".
    String? lastName,
    String? startDate, // e.g. "2025-09-01" or ISO string per backend
    String? endDate, // e.g. "2025-09-05"
    int? userId,
  }) async {
    try {
      final query = <String, dynamic>{
        'search': search,
        'status': status,
        'firstName': firstName, // keep the backend's spelling
        'lastName': lastName,
        'startDate': startDate,
        'endDate': endDate,
        'userId': userId,
        'skip': 0,
        'limit': 1000000,
      };
      log(query.toString());
      final data = await apiServer.getWithQuery(
        endPoint: 'Plate', // baseUrl already includes /api/
        query: query,
        token: kToken,
      );
      log(data.toString());
      final model = AllPlatesModel.fromJson(data); // <-- your model
      return right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
