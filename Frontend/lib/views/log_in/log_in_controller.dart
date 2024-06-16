import 'dart:developer';

import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/repositories/auth/auth_repository.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'bloc/log_in_bloc.dart';

class LogInController {
  final BuildContext context;

  LogInController(this.context);

  final AuthRepository _authRepository = AuthRepository();

  Future<void> logIn() async {
    showDialog(
        context: context,
        builder: (context) => LoadingAnimationWidget.inkDrop(
            color: AppColors.mainBlue, size: 10.swp));
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
          if (credential.user == null) {
            Get.back();
            CustomToast.error(
                'Error', 'User not found. Check your credentials');
          } else if (!credential.user!.emailVerified) {
            Get.back();
            CustomToast.warning(
                'Error', 'Please verify your email before logging in');
            credential.user!.sendEmailVerification();
          } else {
            log(credential.user!.uid);
            log(credential.user!.email!);
            log(credential.user!.displayName!);
            await saveUserLoginData(email);
            Get.offNamedUntil(Routes.NAVPAGE, (route) => false);
            CustomToast.success('Success', 'Logged in successfully');
          }
        } on FirebaseException catch (e) {
          throw Exception(e.message);
        }
      }
    } catch (e) {
      log(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      CustomToast.error('Error', e.toString(), duration: 3);
    }
  }

  Future saveUserLoginData(String email) async {
    var map = {
      'email': email,
    };
    var currentUser = await _authRepository.loginWithEmail(map);
    if (currentUser == null) {
      throw Exception('User not found');
    }
    Global.storageService.setProfile(currentUser);
    ;
  }
}
