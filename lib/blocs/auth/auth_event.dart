part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent(
    this.email,
    this.password,
  );
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(
    this.email,
    this.password,
  );
}

class UpdateAddressEvent extends AuthEvent {
  final String adressLine1;
  final String adressLine2;
  final String city;
  final String district;
  final String postalCode;
  final String contactNumber;

  UpdateAddressEvent(this.adressLine1, this.adressLine2, this.city,
      this.district, this.postalCode, this.contactNumber);
}

class UpdateNameEvent extends AuthEvent {
  final String name;

  UpdateNameEvent(this.name);
}

class LogoutEvent extends AuthEvent {}
