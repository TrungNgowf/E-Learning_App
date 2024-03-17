import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/common/export.dart';
import 'package:e_learning_app/views/log_in/log_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpController {
  final BuildContext context;

  SignUpController(this.context);

  Future<void> signUp() async {
    try {
      final state = context.read<SignUpBloc>().state;
      String username = state.username;
      String email = state.email;
      String password = state.password;
      String confirmPassword = state.confirmPassword;
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          if (credential.user != null) {
            CustomToast.info("Verify your email",
                "A verification email has been sent to your email address.",
                duration: 5);
            await credential.user!.sendEmailVerification();
            await credential.user!.updateDisplayName(username);
            Get.off(() => const LoginScreen());
          }
        } on FirebaseException catch (e) {
          CustomToast.error("Error", e.message!);
          throw Exception(e.message);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
