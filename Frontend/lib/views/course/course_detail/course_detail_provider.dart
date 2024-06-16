import 'package:get/get.dart';

class CourseDetailProvider extends GetxController {
  var courseId = 0.obs;

  void setCourseId(int id) {
    courseId.value = id;
  }
}
