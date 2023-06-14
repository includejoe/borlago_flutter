import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_authentication/data/repository/auth_repo_impl.dart';
import 'package:borlago/feature_authentication/domain/repository/auth_repo.dart';
import 'package:borlago/feature_authentication/domain/use_cases/authentication_use_cases.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/data/repository/user_repo_impl.dart';
import 'package:borlago/feature_user/domain/repository/user_repo.dart';
import 'package:borlago/feature_user/domain/use_cases/user_use_cases.dart';
import 'package:borlago/feature_wcr/data/repository/wcr_repo_impl.dart';
import 'package:borlago/feature_wcr/domain/repository/wcr_repo.dart';
import 'package:borlago/feature_wcr/domain/use_cases/wcr_use_cases.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

final GetIt getIt = GetIt.instance;
final SupabaseClient supabase = SupabaseClient(Constants.supabaseProjectUrl, Constants.supabasePublicKey);

void initialize({required CameraDescription backCamera}) {

  getIt.registerSingleton<CameraDescription>(backCamera);

  // Supabase
  getIt.registerLazySingleton<SupabaseClient>(() => supabase);

  // Authentication
  getIt.registerSingleton<AuthenticationProvider>(AuthenticationProvider());
  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationUseCases>(() => AuthenticationUseCases());

  // User
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<UserUseCases>(() => UserUseCases());

  // Waste Collection Request
  getIt.registerLazySingleton<WCRRepository>(() => WCRRepositoryImpl());
  getIt.registerLazySingleton<WCRUseCases>(() => WCRUseCases());
}