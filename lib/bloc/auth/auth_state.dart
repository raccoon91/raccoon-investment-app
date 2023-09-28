part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

enum Authenticated { unknown, authenticated, unauthenticated }

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final Authenticated authenticated;
  final User? user;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authenticated = Authenticated.unknown,
    User? user,
  }) : user = null;

  AuthState copyWith({
    AuthStatus? status,
    Authenticated? authenticated,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      authenticated: authenticated ?? this.authenticated,
      user: user,
    );
  }

  @override
  List<Object?> get props => [status, authenticated, user];
}
