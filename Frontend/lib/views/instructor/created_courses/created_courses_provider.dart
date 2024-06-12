import 'package:get/get.dart';

class CreatedCoursesProvider extends GetxController {
  var courseId = 0.obs;

  void setCourseId(int id) {
    courseId.value = id;
  }
}
