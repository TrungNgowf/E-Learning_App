import 'dart:math';

import 'package:e_learning_app/main.dart';
import 'package:e_learning_app/utils/storage_service.dart';
import 'package:flutter/material.dart';

String generateHtml(List<TextEditingController> list) {
  String htmlString = """
    <div>
        <ul>
    """;
  for (TextEditingController controller in list) {
    htmlString = """$htmlString
        <li>${controller.text}</li>
      """;
  }
  htmlString = """$htmlString
        </ul>
    </div>
    """;
  return htmlString;
}

String secondsToTime(int seconds) {
  Duration duration = Duration(seconds: seconds);
  String formattedTime =
      "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  return formattedTime;
}

String generateUniqueLiveId() {
  Set<String> generatedStrings = <String>{};
  String chars =
      'abcdefghiklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  int stringLength = 4;

  Random random = Random();
  String uniqueString;

  do {
    uniqueString = List.generate(
        stringLength, (index) => chars[random.nextInt(chars.length)]).join();
  } while (generatedStrings.contains(uniqueString));

  generatedStrings.add(uniqueString);
  uniqueString +=
      Global.storageService.prefs.getInt(AppStorageService.USER_ID)!.toString();
  return uniqueString;
}
