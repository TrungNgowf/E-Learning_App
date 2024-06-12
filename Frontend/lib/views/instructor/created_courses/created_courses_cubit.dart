import 'package:bloc/bloc.dart';
import 'package:e_learning_app/models/course/course_list_for_instructor.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:meta/meta.dart';

part 'created_courses_state.dart';

class CreatedCoursesCubit extends Cubit<CreatedCoursesState> {
  final CourseRepository _courseRepository = CourseRepository();

  CreatedCoursesCubit() : super(CreatedCoursesInitial()) {
    getCoursesForInstructor();
  }

  Future getCoursesForInstructor() async {
    emit(CreatedCoursesLoading());
    try {
      var courses = await _courseRepository.getCoursesForInstructor();
      emit(CreatedCoursesLoaded(courses));
    } catch (e) {
      emit(CreatedCoursesError(e.toString()));
    }
  }
}
