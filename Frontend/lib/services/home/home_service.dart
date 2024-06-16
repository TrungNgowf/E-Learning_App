import 'package:e_learning_app/utils/api_config/http_util.dart';

class HomeService {
  static Future getCoursesPreviewForHomePage(int type) async {
    return await HttpUtil()
        .get('/Course/GetCoursesPreviewForHomePage', query: {'type': type});
  }
}
