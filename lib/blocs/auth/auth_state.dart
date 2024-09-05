part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}

class SuccessLoginState extends AuthState {}

class SuccessLogoutState extends AuthState {}

class SuccessRegisterState extends AuthState{}

class SuccessAddressUpdateState extends AuthState{}