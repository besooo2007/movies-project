abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  ResetPasswordRequested({
    required this.email,
  });
}

class UpdateProfileRequested extends AuthEvent {
  final String name;
  final String? photoUrl;

  UpdateProfileRequested({
    required this.name,
    this.photoUrl,
  });
}

class DeleteAccountRequested extends AuthEvent {}
class SignInWithGoogleRequested extends AuthEvent {}
class GetCurrentUserRequested extends AuthEvent {}