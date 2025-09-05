import 'package:ast_reader/core/utils/api_server.dart';
import 'package:ast_reader/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo_impl.dart';
import 'package:ast_reader/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServer>(ApiServer(
    Dio(),
  ));

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      getIt.get<ApiServer>(),
    ),
  );
  getIt.registerSingleton<CaptureRepoImpl>(
    CaptureRepoImpl(
      getIt.get<ApiServer>(),
    ),
  );
   getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt.get<ApiServer>(),
    ),
  );
}
