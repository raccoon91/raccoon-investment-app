part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class _AuthStatusChanged extends AuthEvent {
  const _AuthStatusChanged(this.status);

  final AuthStatus status;
}

final class AuthLoginCheck extends AuthEvent {}

final class AuthLogoutRequested extends AuthEvent {}
