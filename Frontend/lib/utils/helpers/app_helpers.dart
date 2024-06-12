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
