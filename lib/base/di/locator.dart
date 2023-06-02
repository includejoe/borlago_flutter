import 'package:borlago/feature_authentication/data/repository/auth_repo_impl.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  locator.registerLazySingleton<AuthenticationUseCases>(() => AuthenticationUseCases());
}