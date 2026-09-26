import 'package:app/features/update_profile/use_case/delete_account_use_case.dart';
import 'package:app/features/update_profile/use_case/update_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'update_profile_event.dart';
import 'update_profile_state.dart';

class UpdateProfileBloc
    extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  UpdateProfileBloc({
    required this.updateProfileUseCase,
    required this.deleteAccountUseCase,
  }) : super(UpdateProfileInitial()) {


    on<UpdateProfileRequested>(_updateProfile);

    on<DeleteAccountRequested>(_deleteAccount);
  }


  Future<void> _updateProfile(
    UpdateProfileRequested event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());

    try {
      await updateProfileUseCase(
        name: event.name,
        phone: event.phone,
      );

      emit(
        UpdateProfileSuccess(
          message: 'Profile updated successfully',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileFailure(
          message: e.toString(),
        ),
      );
    }
  }


  Future<void> _deleteAccount(
    DeleteAccountRequested event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(DeleteAccountLoading());

    try {
      await deleteAccountUseCase();

      emit(
        DeleteAccountSuccess(
          message: 'Account deleted successfully',
        ),
      );
    } catch (e) {
      emit(
        DeleteAccountFailure(
          message: e.toString(),
        ),
      );
    }
  }
}