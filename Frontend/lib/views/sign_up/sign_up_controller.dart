import 'dart:developer';

import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/repositories/auth/auth_repository.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpController {
  final BuildContext context;

  SignUpController(this.context);

  AuthRepository _authRepository = AuthRepository();

  Future<void> signUp() async {
    showDialog(
        context: context,
        builder: (context) =>
            LoadingAnimationWidget.inkDrop(
                color: AppColors.mainBlue, size: 10.swp));
    try {
      final state = context
          .read<SignUpBloc>()
          .state;
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
            await credential.user!.sendEmailVerification();
            await credential.user!.updateDisplayName(username);
            CustomToast.info("Verify your email",
                "A verification email has been sent to your email address.",
                duration: 5);
            await saveUserRegistrationData(
                email, username, credential.user!.uid)
                .then((value) => value ? Get.offNamed(Routes.LOGIN) : ());
            // await Get.offNamed(Routes.LOGIN);
          }
        } on FirebaseException catch (e) {
          throw Exception(e.message);
        }
      }
    } catch (e) {
      log(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      CustomToast.error('Error', e.toString(), duration: 5);
    }
  }

  Future<bool> saveUserRegistrationData(String email, String username,
      String firebaseUid) async {
    LoadingAnimationWidget.inkDrop(color: AppColors.mainBlue, size: 50.swp);
    var map = {
      'email': email,
      'username': username,
      'firebaseUID': firebaseUid,
      'accountTypeId': 1,
      'roleIds': [2]
    };
    var response = await _authRepository.signUpWithEmail(map);
    return response;
  }
}
