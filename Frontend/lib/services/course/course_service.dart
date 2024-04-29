import 'package:e_learning_app/utils/api_config/http_util.dart';

class CourseService {
  static Future getCourseCategories() async {
    return await HttpUtil().get('/Course/GetCourseCategories');
  }
}
