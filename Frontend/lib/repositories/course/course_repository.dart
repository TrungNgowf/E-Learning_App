import 'package:e_learning_app/models/course/course_category.dart';
import 'package:e_learning_app/services/course/course_service.dart';

class CourseRepository {
  Future<List<CourseCategory>> getCourseCategories() async {
    try {
      var response = await CourseService.getCourseCategories();
      if (response.statusCode == 200) {
        return courseCategoryFromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
