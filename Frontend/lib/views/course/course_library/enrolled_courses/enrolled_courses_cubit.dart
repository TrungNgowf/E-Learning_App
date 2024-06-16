import 'package:bloc/bloc.dart';
import 'package:e_learning_app/models/course/course_library.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/utils/export.dart';

part 'enrolled_courses_state.dart';

class EnrolledCoursesCubit extends Cubit<EnrolledCoursesState> {
  final CourseRepository _courseRepository = CourseRepository();

  EnrolledCoursesCubit() : super(EnrolledCoursesInitial()) {
    getEnrolledCourses();
  }

  Future getEnrolledCourses() async {
    try {
      emit(EnrolledCoursesLoading());
      final courses = await _courseRepository.getListEnrolledCourses();
      emit(EnrolledCoursesLoaded(courses));
    } catch (e) {
      debugPrint(e.toString());
      emit(EnrolledCoursesError(e.toString()));
    }
  }
}
