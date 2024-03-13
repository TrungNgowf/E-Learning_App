import 'package:e_learning_app/common/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/log_in_bloc.dart';

class LogInController {
  final BuildContext context;

  LogInController(this.context);

  Future<void> logIn() async {
    try {
      final state = context.read<LogInBloc>().state;
      String email = state.email;
      String password = state.password;
      if (email.isNotEmpty && password.isNotEmpty) {
        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
