import 'package:ast_reader/core/errors/failures.dart';
import 'package:ast_reader/features/auth/data/models/sign_up_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignUpModel>> signIn(
      {required String email, required String password});
  Future<Either<Failure, SignUpModel>> signUp(
      {required String email, required String password, required String name});
}
