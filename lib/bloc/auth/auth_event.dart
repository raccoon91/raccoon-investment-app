part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class GetUser extends AuthEvent {}

final class PostSignIn extends AuthEvent {
  final String email;
  final String password;

  PostSignIn(this.email, this.password);
}

final class PostSignOut extends AuthEvent {}
