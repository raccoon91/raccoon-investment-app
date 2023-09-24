import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raccoon_investment/repository/auth_repository.dart';
import 'package:raccoon_investment/repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<_AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLoginCheck>(_onAuthCheck);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status.listen(
      (status) => add(_AuthStatusChanged(status)),
    );
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthStatus> _authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();

    return super.close();
  }

  Future<void> _onAuthStatusChanged(
    _AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        final user = _tryGetUser();

        return emit(
          user != null
              ? AuthState.authenticated(user)
              : const AuthState.unauthenticated(),
        );
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthCheck(
    AuthLoginCheck event,
    Emitter<AuthState> emit,
  ) {
    final user = _userRepository.getUser();

    _authRepository.authCheck(user: user);
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }

  User? _tryGetUser() {
    try {
      final user = _userRepository.getUser();

      return user;
    } catch (_) {
      return null;
    }
  }
}
