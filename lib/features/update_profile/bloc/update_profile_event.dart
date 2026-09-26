abstract class UpdateProfileEvent {}

class UpdateProfileRequested extends UpdateProfileEvent {
  final String name;
  final String phone;

  UpdateProfileRequested({
    required this.name,
    required this.phone,
  });
}

class DeleteAccountRequested extends UpdateProfileEvent {}