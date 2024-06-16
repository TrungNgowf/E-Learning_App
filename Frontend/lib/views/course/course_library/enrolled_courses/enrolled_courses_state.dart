part of 'enrolled_courses_cubit.dart';

@immutable
sealed class EnrolledCoursesState {}

final class EnrolledCoursesInitial extends EnrolledCoursesState {}

final class EnrolledCoursesLoading extends EnrolledCoursesState {}

final class EnrolledCoursesLoaded extends EnrolledCoursesState {
  final List<CourseLibraryDto> courses;

  EnrolledCoursesLoaded(this.courses);
}

final class EnrolledCoursesError extends EnrolledCoursesState {
  final String message;

  EnrolledCoursesError(this.message);
}
