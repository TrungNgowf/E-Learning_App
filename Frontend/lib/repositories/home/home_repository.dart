import 'package:e_learning_app/models/course/course_card_for_home_page.dart';
import 'package:e_learning_app/services/home/home_service.dart';

class HomeRepository {
  Future<List<CourseCardForHomePage>> getCoursesPreviewForHomePage(
      int type) async {
    try {
      var response = await HomeService.getCoursesPreviewForHomePage(type);
      if (response.statusCode == 200) {
        return courseCardForHomePageFromJson(response.data as List);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
