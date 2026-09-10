import 'package:app/features/auth/data/data_source/auth_remote_data_imp.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';
import 'package:app/features/auth/domin/repositories/auth_repo_imp.dart';
import 'package:app/features/auth/domin/use_cases/delete_account_usecase.dart';
import 'package:app/features/auth/domin/use_cases/restpassword_usecase.dart';
import 'package:app/features/auth/domin/use_cases/sign_in_usecase.dart';
import 'package:app/features/auth/domin/use_cases/sign_up_usecase.dart';
import 'package:app/features/auth/domin/use_cases/signin_with_google.dart';
import 'package:app/features/auth/domin/use_cases/update_profile_usecase.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../data/data_source/auth_remote_data_source.dart';

final getIt = GetIt.instance;

void setupAuthInjection() {
  getIt.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<SignIn>(
    () => SignIn(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignUp>(
    () => SignUp(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<ResetPassword>(
    () => ResetPassword(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateProfile>(
    () => UpdateProfile(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteAccount>(
    () => DeleteAccount(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      signIn: getIt<SignIn>(),
      signUp: getIt<SignUp>(),
      signInWithGoogle: getIt<SignInWithGoogle>(),
      resetPassword: getIt<ResetPassword>(),
      updateProfile: getIt<UpdateProfile>(),
      deleteAccount: getIt<DeleteAccount>(),
    ),
  );
}