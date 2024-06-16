import 'package:bloc/bloc.dart';
import 'package:e_learning_app/models/course/course_library.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/utils/export.dart';

part 'favorite_courses_state.dart';

class FavoriteCoursesCubit extends Cubit<FavoriteCoursesState> {
  final CourseRepository _courseRepository = CourseRepository();

  FavoriteCoursesCubit() : super(FavoriteCoursesInitial()) {
    getListFavoriteCourses();
  }

  Future getListFavoriteCourses() async {
    try {
      emit(FavoriteCoursesLoading());
      final courses = await _courseRepository.getListFavoriteCourses();
      emit(FavoriteCoursesLoaded(courses));
    } catch (e) {
      debugPrint(e.toString());
      emit(FavoriteCoursesError(e.toString()));
    }
  }
}
