part of 'created_courses_cubit.dart';

@immutable
sealed class CreatedCoursesState {}

final class CreatedCoursesInitial extends CreatedCoursesState {}

final class CreatedCoursesLoading extends CreatedCoursesState {}

final class CreatedCoursesLoaded extends CreatedCoursesState {
  final List<CourseListForInstructor> courses;

  CreatedCoursesLoaded(this.courses);
}

final class CreatedCoursesError extends CreatedCoursesState {
  final String message;

  CreatedCoursesError(this.message);
}
