part of 'course_preview_cubit.dart';

@immutable
sealed class CoursePreviewState {}

final class CoursePreviewInitial extends CoursePreviewState {}

final class CoursePreviewLoading extends CoursePreviewState {}

final class CoursePreviewLoaded extends CoursePreviewState {
  final CoursePreviewForInstructor course;

  CoursePreviewLoaded(this.course);
}

final class CoursePreviewError extends CoursePreviewState {
  final String message;

  CoursePreviewError(this.message);
}
