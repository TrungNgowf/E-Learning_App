import 'package:e_learning_app/common/custom_button.dart';
import 'package:e_learning_app/models/course/course_list_for_instructor.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'created_courses_cubit.dart';
import 'created_courses_provider.dart';

class CreatedCourses extends StatefulWidget {
  const CreatedCourses({super.key});

  @override
  State<CreatedCourses> createState() => _CreatedCoursesState();
}

class _CreatedCoursesState extends State<CreatedCourses> {
  final CreatedCoursesCubit _createdCoursesCubit = CreatedCoursesCubit();
  DateFormat formatter = DateFormat('yyyy/MM/dd hh:mm a');

  @override
  Widget build(BuildContext context) {
    Get.put(CreatedCoursesProvider());
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.swp, vertical: 1.shp),
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
            ),
            Gap(2.shp),
            Align(
              alignment: Alignment.centerLeft,
              child: ReusableText(
                "Courses you have created",
                style: appStyle(size: 18, fw: FontWeight.w600),
              ),
            ),
            Gap(1.shp),
            BlocBuilder(
                bloc: _createdCoursesCubit,
                builder: (context, state) {
                  if (state is CreatedCoursesLoading) {
                    return Container(
                        margin: EdgeInsets.only(top: 5.swp),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  } else if (state is CreatedCoursesLoaded) {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          return courseCard(
                            course: state.courses[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Gap(1.shp);
                        },
                      ),
                    );
                  } else if (state is CreatedCoursesError) {
                    return Center(
                      child: ReusableText(
                        "Something went wrong!\nTry again later.",
                        maxLines: 2,
                        style: appStyle(
                            size: 15, fw: FontWeight.w600, color: Colors.red),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget courseCard({required CourseListForInstructor course}) {
    return GestureDetector(
      onTap: () {
        Get.find<CreatedCoursesProvider>().setCourseId(course.id);
        Get.toNamed(Routes.COURSE_PREVIEW);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 1.shp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  course.thumbnail,
                  width: 30.swp,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(4.swp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReusableText(
                      course.title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: appStyle(size: 16, fw: FontWeight.w600),
                    ),
                    Gap(0.5.shp),
                    ReusableText(
                      formatter.format(course.creationTime),
                      style: appStyle(
                          size: 14,
                          color: Colors.blueGrey.shade300,
                          fw: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
