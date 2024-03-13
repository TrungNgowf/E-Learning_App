import 'package:e_learning_app/common/export.dart';

extension SizeConfig on num {
  double get swp => 0.01.sw * this;

  double get shp => 0.01.sh * this;
}

class AppColors {
  static const mainBlue = Color(0xFF2866F1);
  static const iosBlue = Color(0xFF0a84ff);
}
