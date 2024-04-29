part of 'adding_course_bloc.dart';

class AddingCourseState {
  final ApiStatus apiStatus;
  final int lessonCount;
  final List<CourseCategory> courseCategories;
  final File? thumbnail;
  final int whatYouWillLearnCount;
  final int requirementCount;
  final int includeCount;

  const AddingCourseState({
    this.apiStatus = ApiStatus.loading,
    this.lessonCount = 1,
    this.courseCategories = const [],
    this.thumbnail,
    this.whatYouWillLearnCount = 1,
    this.requirementCount = 1,
    this.includeCount = 1,
  });

  AddingCourseState copyWith({
    ApiStatus? apiStatus,
    int? lessonCount,
    List<CourseCategory>? courseCategories,
    File? thumbnail,
    int? whatYouWillLearnCount,
    int? requirementCount,
    int? includeCount,
  }) {
    return AddingCourseState(
      apiStatus: apiStatus ?? this.apiStatus,
      lessonCount: lessonCount ?? this.lessonCount,
      courseCategories: courseCategories ?? this.courseCategories,
      thumbnail: thumbnail ?? this.thumbnail,
      whatYouWillLearnCount:
          whatYouWillLearnCount ?? this.whatYouWillLearnCount,
      requirementCount: requirementCount ?? this.requirementCount,
      includeCount: includeCount ?? this.includeCount,
    );
  }

  AddingCourseState removeThumbnail() {
    return AddingCourseState(
      apiStatus: apiStatus,
      lessonCount: lessonCount,
      courseCategories: courseCategories,
      whatYouWillLearnCount: whatYouWillLearnCount,
      requirementCount: requirementCount,
      includeCount: includeCount,
      thumbnail: null,
    );
  }
}
