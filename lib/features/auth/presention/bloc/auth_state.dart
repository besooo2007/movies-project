import 'package:app/features/auth/domin/entities/user_entity.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity? user;
  final String? message;

  AuthSuccess({
    this.user,
    this.message,
  });
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}