import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/repository/auth_repository.dart';
import 'package:raccoon_investment/repository/user_repository.dart';
import 'package:raccoon_investment/screen/home_screen.dart';
import 'package:raccoon_investment/screen/login_screen.dart';
import 'package:raccoon_investment/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepository: _authRepository,
          userRepository: _userRepository,
        ),
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          theme: ThemeClass.theme,
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil(
                      LoginScreen.route(),
                      (route) => false,
                    );
                  case AuthStatus.authenticated:
                    _navigator.pushAndRemoveUntil(
                      HomeScreen.route(),
                      (route) => false,
                    );
                  default:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => LoginScreen.route(),
        ),
      ),
    );
  }
}
