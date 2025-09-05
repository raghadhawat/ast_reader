import 'dart:io';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/core/utils/api_server.dart';
import 'package:ast_reader/features/capture/data/models/add_photo_model.dart';
import 'package:ast_reader/features/capture/data/models/status_model.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CaptureRepoImpl implements CaptureRepo {
  final ApiServer apiServer;

  CaptureRepoImpl(this.apiServer);

  @override
  Future<Either<Failure, AddPhotoModel>> addPhoto({
    required dynamic image, // XFile | File | String (path)
    String fieldName = 'media', // matches your Swagger
    String endPoint = 'media/upload', // relative to ApiServer.baseUrl
    String? token, // if auth required
  }) async {
    try {
      // ---- Resolve filePath + fileName safely (no `path` package needed)
      late final String filePath;
      late final String fileName;

      if (image is XFile) {
        filePath = image.path;
        fileName = image.name;
      } else if (image is File) {
        filePath = image.path;
        fileName = filePath.split(Platform.pathSeparator).last;
      } else if (image is String) {
        filePath = image;
        fileName = filePath.split(Platform.pathSeparator).last;
      } else {
        throw ArgumentError('image must be XFile, File, or String path');
      }

      // Optional: ensure the file actually exists on disk
      if (!await File(filePath).exists()) {
        return left(ServerFailure('File not found at path: $filePath'));
      }

      final form = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });

      // If you added `addPhoto` in ApiServer, keep this:
      final data = await apiServer.addPhoto(
        endPoint: endPoint,
        formData: form,
        token: kToken,
      );

      // If you DON'T have addPhoto in ApiServer, uncomment this instead:
      // final data = await apiServer.post(
      //   endPoint: endPoint,
      //   body: form,
      //   token: token,
      // );

      final model = AddPhotoModel.fromJson(data);
      return right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StatusModel>> rejectPlate(
      {required int plateId}) async {
    try {
      var data = await apiServer.patch(
          endPoint: 'Plate/result/$plateId/reject', body: null, token: kToken);

      StatusModel statusModel = StatusModel.fromJson(data);

      return right(statusModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, StatusModel>> acceptPlate({required int plateId}) async {
    try {
      var data = await apiServer.patch(
          endPoint: 'Plate/result/$plateId/accept', body: null, token: kToken);

      StatusModel statusModel = StatusModel.fromJson(data);

      return right(statusModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, StatusModel>> confusePlate({required int plateId}) async {
    try {
      var data = await apiServer.patch(
          endPoint: 'Plate/result/$plateId/confuse', body: null, token: kToken);

      StatusModel statusModel = StatusModel.fromJson(data);

      return right(statusModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
