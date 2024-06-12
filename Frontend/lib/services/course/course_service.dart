import 'package:e_learning_app/utils/api_config/http_util.dart';

class CourseService {
  static Future getCourseCategories() async {
    return await HttpUtil().get('/Course/GetCourseCategories');
  }

  static Future createCourse(Map<String, dynamic> data) async {
    return await HttpUtil().post('/Course/CreateCourse', data: data);
  }

  static Future getCoursesForInstructor() async {
    return await HttpUtil().get('/Course/GetCoursesForInstructor');
  }

  static Future getCoursePreviewForInstructor(int courseId) async {
    return await HttpUtil().get('/Course/GetCoursePreviewForInstructor',
        query: {'courseId': courseId});
  }
}
