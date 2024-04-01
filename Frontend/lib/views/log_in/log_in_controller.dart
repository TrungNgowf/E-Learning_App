import 'dart:developer';

import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/main.dart';
import 'package:e_learning_app/utils/export.dart';
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
          if (credential.user == null) {
            CustomToast.error(
                'Error', 'User not found. Check your credentials');
          } else if (!credential.user!.emailVerified) {
            CustomToast.warning(
                'Error', 'Please verify your email before logging in');
          } else {
            log(credential.user!.uid);
            log(credential.user!.email!);
            log(credential.user!.displayName!);
            Global.storageService.setString(
                AppStorageService.USER_TOKEN_KEY, credential.user!.uid);
            Get.offNamedUntil(Routes.NAVPAGE, (route) => false);
            CustomToast.success('Success', 'Logged in successfully');
          }
        } on FirebaseException catch (e) {
          throw Exception(e.message);
        }
      }
    } catch (e) {
      log(e.toString());
      CustomToast.error('Error', e.toString(), duration: 5);
    }
  }
}
