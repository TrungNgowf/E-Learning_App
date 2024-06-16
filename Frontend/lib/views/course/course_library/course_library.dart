import 'package:e_learning_app/utils/export.dart';

import 'enrolled_courses/enrolled_courses_view.dart';
import 'favorite_courses/favorite_courses_view.dart';

class CourseLibrary extends StatefulWidget {
  const CourseLibrary({super.key});

  @override
  State<CourseLibrary> createState() => _CourseLibraryState();
}

class _CourseLibraryState extends State<CourseLibrary> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: ReusableText(
            'Course Library',
            style: appStyle(size: 18, color: Colors.black, fw: FontWeight.w500),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            labelColor: AppColors.mainBlue,
            indicatorColor: AppColors.mainBlue,
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      "Enrolled  ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.ondemand_video,
                    ),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      "Favorite  ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.favorite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [EnrolledCoursesView(), FavoriteCoursesView()],
        ),
      ),
    );
  }
}
