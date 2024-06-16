import 'package:e_learning_app/models/course/course_library.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'favorite_courses_cubit.dart';

class FavoriteCoursesView extends StatefulWidget {
  const FavoriteCoursesView({super.key});

  @override
  State<FavoriteCoursesView> createState() => _FavoriteCoursesViewState();
}

class _FavoriteCoursesViewState extends State<FavoriteCoursesView> {
  final FavoriteCoursesCubit _favorCubit = FavoriteCoursesCubit();
  DateFormat formatter = DateFormat('yyyy/MM/dd hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.swp, vertical: 2.shp),
      child: BlocBuilder<FavoriteCoursesCubit, FavoriteCoursesState>(
        bloc: _favorCubit,
        builder: (context, state) {
          if (state is FavoriteCoursesInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteCoursesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteCoursesLoaded) {
            return SizedBox(
              height: 80.shp,
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
          } else if (state is FavoriteCoursesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget courseCard({required CourseLibraryDto course}) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(Routes.COURSE_DETAIL, arguments: course.id)!
            .then((value) {
          _favorCubit.getListFavoriteCourses();
        });
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
                      course.author,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: appStyle(size: 13, fw: FontWeight.w300),
                    ),
                    Gap(0.5.shp),
                    Row(
                      children: [
                        course.categories
                            .map((e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.swp, vertical: 0.5.swp),
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal:
                                  //         1.swp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.mainBlue, width: 1),
                                  ),
                                  child: Text(e,
                                      style: appStyle(
                                          size: 10,
                                          color: AppColors.mainBlue,
                                          fw: FontWeight.w200)),
                                ))
                            .toList()[0],
                      ],
                    ),
                    Gap(0.5.shp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ReusableText(
                          '\$${course.coursePrice}',
                          style: appStyle(
                              size: 14,
                              color: Colors.blueAccent.shade400,
                              fw: FontWeight.w300),
                        ),
                      ],
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
