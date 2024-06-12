part of 'adding_course_bloc.dart';

class AddingCourseState {
  final ApiStatus apiStatus;
  final List<CourseCategory> courseCategories;
  final File? thumbnail;
  final int whatYouWillLearnCount;
  final int requirementCount;
  final int includeCount;
  final List<FlickManager?> lessonVideos;
  final List<File?> lessonFiles;

  const AddingCourseState({
    this.apiStatus = ApiStatus.loading,
    this.courseCategories = const [],
    this.thumbnail,
    this.whatYouWillLearnCount = 1,
    this.requirementCount = 1,
    this.includeCount = 1,
    this.lessonVideos = const [null],
    this.lessonFiles = const [null],
  });

  AddingCourseState copyWith({
    ApiStatus? apiStatus,
    List<CourseCategory>? courseCategories,
    File? thumbnail,
    int? whatYouWillLearnCount,
    int? requirementCount,
    int? includeCount,
    List<FlickManager?>? lessonVideos,
    List<File?>? lessonFiles,
  }) {
    return AddingCourseState(
      apiStatus: apiStatus ?? this.apiStatus,
      courseCategories: courseCategories ?? this.courseCategories,
      thumbnail: thumbnail ?? this.thumbnail,
      whatYouWillLearnCount:
          whatYouWillLearnCount ?? this.whatYouWillLearnCount,
      requirementCount: requirementCount ?? this.requirementCount,
      includeCount: includeCount ?? this.includeCount,
      lessonVideos: lessonVideos ?? this.lessonVideos,
      lessonFiles: lessonFiles ?? this.lessonFiles,
    );
  }

  AddingCourseState removeThumbnail() {
    return AddingCourseState(
      apiStatus: apiStatus,
      courseCategories: courseCategories,
      whatYouWillLearnCount: whatYouWillLearnCount,
      requirementCount: requirementCount,
      includeCount: includeCount,
      lessonVideos: lessonVideos,
      lessonFiles: lessonFiles,
      thumbnail: null,
    );
  }

  AddingCourseState initialSetup() {
    return const AddingCourseState(
      apiStatus: ApiStatus.loading,
      courseCategories: [],
      thumbnail: null,
      whatYouWillLearnCount: 1,
      requirementCount: 1,
      includeCount: 1,
      lessonVideos: [null],
      lessonFiles: [null],
    );
  }
}
