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
