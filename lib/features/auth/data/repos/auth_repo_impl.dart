import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/core/utils/api_server.dart';
import 'package:ast_reader/features/auth/data/models/sign_up_model.dart';
import 'package:ast_reader/features/auth/data/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiServer apiServer;

  AuthRepoImpl(this.apiServer);

  @override
  Future<Either<Failure, SignUpModel>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var data = await apiServer.post(endPoint: 'auth/register', body: {
        "email": email,
        "password": password,
        "name": name,
      });

      SignUpModel signUpModel = SignUpModel.fromJson(data);

      return right(signUpModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignUpModel>> signIn(
      {required String email, required String password}) async {
    try {
      var data = await apiServer.post(endPoint: 'auth/login', body: {
        "email": email,
        "password": password,
      });

      SignUpModel signUpModel = SignUpModel.fromJson(data);

      return right(signUpModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
