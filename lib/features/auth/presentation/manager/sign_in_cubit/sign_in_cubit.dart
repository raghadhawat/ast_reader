import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/secure_storage.dart';
import 'package:ast_reader/features/auth/data/models/sign_up_model.dart';
import 'package:ast_reader/features/auth/data/repos/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(SignInInitial());

  final AuthRepo authRepo;
  Future<void> signInCubitFun({
    required String email,
    required String password,
  }) async {
    emit(SignInLoading());
    var result = await authRepo.signIn(
      email: email,
      password: password,
    );
    result.fold((failure) {
      emit(SignInFailure(errMessage: failure.errMessage));
    }, (signUpModel) async {
      SecureStorage().writeSecureData(tokenKey, signUpModel.accessToken!);
      await loadToken();
      emit(SignInsuccess(signUpModel: signUpModel));
    });
  }
}
