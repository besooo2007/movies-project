import 'package:app/features/auth/domin/use_cases/delete_account_usecase.dart';
import 'package:app/features/auth/domin/use_cases/restpassword_usecase.dart';
import 'package:app/features/auth/domin/use_cases/sign_in_usecase.dart';

import 'package:app/features/auth/domin/use_cases/sign_up_usecase.dart';
import 'package:app/features/auth/domin/use_cases/signin_with_google.dart';
import 'package:app/features/auth/domin/use_cases/update_profile_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final SignInWithGoogle signInWithGoogle;
  final ResetPassword resetPassword;
  final UpdateProfile updateProfile;
  final DeleteAccount deleteAccount;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.signInWithGoogle,
    required this.resetPassword,
    required this.updateProfile,
    required this.deleteAccount,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_signIn);
    on<SignUpRequested>(_signUp);
    on<SignInWithGoogleRequested>(_signInWithGoogle);
    on<ResetPasswordRequested>(_resetPassword);
    on<UpdateProfileRequested>(_updateProfile);
    on<DeleteAccountRequested>(_deleteAccount);
  }

  Future<void> _signIn(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signIn(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> _signUp(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await signInWithGoogle();

      emit(AuthSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> _resetPassword(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await resetPassword(
        email: event.email,
      );

      emit(
        AuthSuccess(
          message: 'Password reset email sent',
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> _updateProfile(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await updateProfile(
        name: event.name,
        photoUrl: event.photoUrl,
      );

      emit(AuthSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  Future<void> _deleteAccount(
    DeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await deleteAccount();

      emit(
        AuthSuccess(
          message: 'Account deleted successfully',
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_getFirebaseError(e)));
    } catch (e) {
      emit(AuthFailure('Something went wrong'));
    }
  }

  String _getFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'Email or password is incorrect';

      case 'invalid-email':
        return 'Invalid email';

      case 'user-not-found':
        return 'User not found';

      case 'wrong-password':
        return 'Wrong password';

      case 'email-already-in-use':
        return 'Email already in use';

      case 'weak-password':
        return 'Password is too weak';

      case 'network-request-failed':
        return 'Check your internet connection';

      case 'too-many-requests':
        return 'Too many requests, try again later';

      case 'requires-recent-login':
        return 'Please login again before deleting your account';

      case 'popup-closed-by-user':
        return 'Google login was cancelled';

      case 'account-exists-with-different-credential':
        return 'This email is already registered with another login method';

      default:
        return e.message ?? 'Authentication failed';
    }
  }
}