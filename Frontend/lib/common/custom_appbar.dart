import 'package:e_learning_app/utils/export.dart';
import 'package:get/get.dart';

AppBar CustomAppbar(
    {required String title, Widget? leading, List<Widget>? trailing}) {
  return AppBar(
    title: ReusableText(
      title,
      style: appStyle(size: 18, color: Colors.black, fw: FontWeight.w500),
    ),
    centerTitle: true,
    leading: leading ??
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
    actions: trailing ?? [],
  );
}
