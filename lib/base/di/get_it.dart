import 'package:borlago/feature_authentication/data/repository/auth_repo_impl.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:borlago/feature_authentication/presentation/auth_view_model.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/data/repository/user_repo_impl.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';
import 'package:borlago/feature_user/domain/use_cases/user_use_cases.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initialize({required CameraDescription backCamera}) {
  // Camera
  getIt.registerSingleton<CameraDescription>(backCamera);

  // Authentication
  getIt.registerSingleton<AuthenticationProvider>(AuthenticationProvider());
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationUseCases>(() => AuthenticationUseCases());

  // User
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<UserUseCases>(() => UserUseCases());
}