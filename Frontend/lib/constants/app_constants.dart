import 'package:e_learning_app/utils/export.dart';

extension SizeConfig on num {
  double get swp => 0.01.sw * this;

  double get shp => 0.01.sh * this;
}

class AppColors {
  static const mainBlue = Color(0xFF2866F1);
  static const iosBlue = Color(0xFF0a84ff);
  static const mainGreen = Color(0xFF00B686);
  static const mainRed = Color(0xFFE02020);
  static const mainYellow = Color(0xFFE7B416);
  static const blueGreenGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      mainBlue,
      mainGreen,
    ],
  );
}
