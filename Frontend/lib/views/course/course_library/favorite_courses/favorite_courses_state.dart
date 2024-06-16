part of 'favorite_courses_cubit.dart';

@immutable
sealed class FavoriteCoursesState {}

final class FavoriteCoursesInitial extends FavoriteCoursesState {}

final class FavoriteCoursesLoading extends FavoriteCoursesState {}

final class FavoriteCoursesLoaded extends FavoriteCoursesState {
  final List<CourseLibraryDto> courses;

  FavoriteCoursesLoaded(this.courses);
}

final class FavoriteCoursesError extends FavoriteCoursesState {
  final String message;

  FavoriteCoursesError(this.message);
}
