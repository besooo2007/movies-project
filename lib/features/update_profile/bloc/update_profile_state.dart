abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String message;

  UpdateProfileSuccess({
    required this.message,
  });
}

class UpdateProfileFailure extends UpdateProfileState {
  final String message;

  UpdateProfileFailure({
    required this.message,
  });
}

class DeleteAccountLoading extends UpdateProfileState {}

class DeleteAccountSuccess extends UpdateProfileState {
  final String message;

  DeleteAccountSuccess({
    required this.message,
  });
}

class DeleteAccountFailure extends UpdateProfileState {
  final String message;

  DeleteAccountFailure({
    required this.message,
  });
}