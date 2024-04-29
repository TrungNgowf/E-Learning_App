import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreatedCourses extends StatefulWidget {
  const CreatedCourses({super.key});

  @override
  State<CreatedCourses> createState() => _CreatedCoursesState();
}

class _CreatedCoursesState extends State<CreatedCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "My Courses",
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
        ),
        trailing: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(2.shp),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                height: 7.shp,
                width: 80.swp,
                backGroundColor: Colors.white,
                border: const GradientBoxBorder(
                  gradient: LinearGradient(
                      colors: [AppColors.mainBlue, AppColors.mainGreen]),
                ),
                onTap: () {
                  Get.toNamed(Routes.ADDING_COURSE);
                },
                child: GradientText(
                  "Create a new course",
                  style: appStyle(
                    size: 16,
                    fw: FontWeight.w600,
                  ),
                  colors: const [AppColors.mainBlue, AppColors.mainGreen],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
