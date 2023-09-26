import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:raccoon_investment/bloc/login/login_bloc.dart';
import 'package:raccoon_investment/repository/auth_repository.dart';
import 'package:raccoon_investment/widget/input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 38,
                  horizontal: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 60),
                          Text(
                            "Welcom Back !",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: BlocProvider(
                        create: (context) {
                          return LoginBloc(
                            authRepository:
                                RepositoryProvider.of<AuthRepository>(context),
                          );
                        },
                        child: BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status.isFailure) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                      content: Text('Authentication Failure')),
                                );
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BlocBuilder<LoginBloc, LoginState>(
                                buildWhen: (previous, current) =>
                                    previous.email != current.email,
                                builder: (context, state) {
                                  return Input(
                                    id: 'login_screen_email_input',
                                    type: "email",
                                    label: "Email",
                                    icon: Icons.person,
                                    error: state.email.displayError != null
                                        ? 'invalid email'
                                        : null,
                                    onChanged: (username) => context
                                        .read<LoginBloc>()
                                        .add(LoginEmailChanged(username)),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<LoginBloc, LoginState>(
                                buildWhen: (previous, current) =>
                                    previous.password != current.password,
                                builder: (context, state) {
                                  return Input(
                                    id: "login_screen_password_input",
                                    type: "password",
                                    label: "password",
                                    icon: Icons.lock,
                                    error: state.password.displayError != null
                                        ? 'invalid password'
                                        : null,
                                    onChanged: (password) => context
                                        .read<LoginBloc>()
                                        .add(LoginPasswordChanged(password)),
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  return state.status.isInProgress
                                      ? const CircularProgressIndicator()
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: ElevatedButton(
                                            key: const Key(
                                                'login_screen_submit_button'),
                                            onPressed: state.isValid
                                                ? () {
                                                    context.read<LoginBloc>().add(
                                                        const LoginSubmitted());
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                              foregroundColor: Colors.white,
                                              disabledBackgroundColor:
                                                  Colors.grey.shade400,
                                              disabledForegroundColor:
                                                  Colors.grey.shade800,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
