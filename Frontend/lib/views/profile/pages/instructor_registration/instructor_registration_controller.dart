import 'package:e_learning_app/utils/export.dart';

class InstructorRegistrationController {
  const InstructorRegistrationController();

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
}
