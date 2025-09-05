import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/secure_storage.dart';
import 'package:ast_reader/features/auth/data/models/sign_up_model.dart';
import 'package:ast_reader/features/auth/data/repos/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;
  Future<void> signUpCubitFun(
      {required String email,
      required String password,
      required String name}) async {
    emit(SignUpLoading());
    var result =
        await authRepo.signUp(email: email, password: password, name: name);
    result.fold((failure) {
      emit(SignUpFailure(errMessage: failure.errMessage));
    }, (signUpModel) async {
      SecureStorage().writeSecureData(tokenKey, signUpModel.accessToken!);
      await loadToken();
      emit(SignUpSuccess(signUpModel: signUpModel));
    });
  }
}
