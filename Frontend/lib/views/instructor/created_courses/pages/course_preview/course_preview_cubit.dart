import 'package:bloc/bloc.dart';
import 'package:e_learning_app/models/course/course_preview_for_instructor.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:e_learning_app/views/instructor/created_courses/created_courses_provider.dart';

part 'course_preview_state.dart';

class CoursePreviewCubit extends Cubit<CoursePreviewState> {
  CourseRepository repository = CourseRepository();

  CoursePreviewCubit() : super(CoursePreviewInitial()) {
    getCoursePreviewForInstructor(createdCoursesProvider.courseId.value);
  }

  final createdCoursesProvider = Get.find<CreatedCoursesProvider>();

  Future getCoursePreviewForInstructor(int courseId) async {
    emit(CoursePreviewLoading());
    try {
      CoursePreviewForInstructor response =
          await repository.getCoursePreviewForInstructor(courseId);
      emit(CoursePreviewLoaded(response));
    } catch (e) {
      emit(CoursePreviewError(e.toString()));
    }
  }
}
