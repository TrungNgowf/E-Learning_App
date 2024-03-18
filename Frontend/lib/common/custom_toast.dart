import 'package:get/get.dart';

import '../utils/export.dart';

class CustomToast {
  static void info(String title, String message, {int duration = 2}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.mainBlue,
      colorText: Colors.white,
      borderRadius: 10,
      duration: Duration(seconds: duration),
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  static void error(String title, String message, {int duration = 2}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 10,
      duration: Duration(seconds: duration),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static void success(String title, String message, {int duration = 2}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      duration: Duration(seconds: duration),
      icon: const Icon(Icons.check, color: Colors.white),
    );
  }

  static void warning(String title, String message, {int duration = 2}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.yellow[700],
      colorText: Colors.white,
      borderRadius: 10,
      duration: Duration(seconds: duration),
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }
}
