import 'package:e_learning_app/generated/assets.dart';
import 'package:e_learning_app/utils/export.dart';

Widget ErrorBlock() {
  return Padding(
    padding: EdgeInsets.all(3.swp),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.iconsError, height: 100, width: 100),
          Gap(2.shp),
          ReusableText(
            "Something went wrong,\nplease try again later",
            maxLines: 2,
            style: appStyle(size: 16, color: Colors.black, fw: FontWeight.w500),
          ),
          Gap(20.shp),
        ],
      ),
    ),
  );
}
