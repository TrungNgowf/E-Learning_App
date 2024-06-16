part of 'course_detail_cubit.dart';

@immutable
sealed class CourseDetailState {}

final class CourseDetailInitial extends CourseDetailState {}

final class CourseDetailLoading extends CourseDetailState {}

final class CourseDetailLoaded extends CourseDetailState {
  final CourseDetailDto course;

  CourseDetailLoaded(this.course);
}

final class CourseDetailError extends CourseDetailState {
  final String message;

  CourseDetailError(this.message);
}
