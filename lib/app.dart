import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raccoon_investment/bloc/auth/auth_bloc.dart';
import 'package:raccoon_investment/repository/auth_repository.dart';
import 'package:raccoon_investment/screen/login_screen.dart';
import 'package:raccoon_investment/screen/main_screen.dart';
import 'package:raccoon_investment/theme/theme.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: AuthRepository(),
      )..add(GetUser()),
      child: MaterialApp(
        theme: ThemeClass.theme,
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listenWhen: ((previous, current) {
              return previous.authenticated != current.authenticated;
            }),
            listener: (context, state) {
              switch (state.authenticated) {
                case Authenticated.unauthenticated:
                  _navigator.pushAndRemoveUntil(
                    LoginScreen.route(),
                    (route) => false,
                  );
                case Authenticated.authenticated:
                  _navigator.pushAndRemoveUntil(
                    MainScreen.route(),
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
    );
  }
}
