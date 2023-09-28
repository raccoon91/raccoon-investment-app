import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<GetUser>(onGetUser);
    on<PostSignIn>(onPostSignIn);
    on<PostSignOut>(onPostSignOut);
  }

  void onGetUser(GetUser event, Emitter<AuthState> emit) {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final user = authRepository.getUser();

      final authenticated = user != null
          ? Authenticated.authenticated
          : Authenticated.unauthenticated;

      emit(
        state.copyWith(
          status: AuthStatus.success,
          authenticated: authenticated,
          user: user?.email,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure));

      throw Exception(error);
    }
  }

  Future<void> onPostSignIn(PostSignIn event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final res = await authRepository.postSignIn(
        email: event.email,
        password: event.password,
      );

      final user = res.user;
      final authenticated = user != null
          ? Authenticated.authenticated
          : Authenticated.unauthenticated;

      emit(
        state.copyWith(
          status: AuthStatus.success,
          authenticated: authenticated,
          user: user?.email,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure));

      throw Exception(error);
    }
  }

  Future<void> onPostSignOut(PostSignOut event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      await authRepository.postSignOut();

      emit(
        state.copyWith(
          status: AuthStatus.success,
          authenticated: Authenticated.unauthenticated,
          user: null,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AuthStatus.failure));

      throw Exception(error);
    }
  }
}
