import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:raccoon_investment/bloc/login/login_bloc.dart';
import 'package:raccoon_investment/widget/input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return Input(
                  id: 'login_screen_email_input',
                  type: "email",
                  label: "Email",
                  error:
                      state.email.displayError != null ? 'invalid email' : null,
                  onChanged: (username) => context
                      .read<LoginBloc>()
                      .add(LoginEmailChanged(username)),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(12)),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return Input(
                  id: "login_screen_password_input",
                  type: "password",
                  label: "password",
                  error: state.password.displayError != null
                      ? 'invalid password'
                      : null,
                  onChanged: (password) => context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(password)),
                );
              },
            ),
            const Padding(padding: EdgeInsets.all(12)),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.status.isInProgress
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          key: const Key('login_screen_submit_button'),
                          onPressed: state.isValid
                              ? () {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade100,
                            disabledForegroundColor: Colors.grey.shade400,
                          ),
                          child: const Text('Login'),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
