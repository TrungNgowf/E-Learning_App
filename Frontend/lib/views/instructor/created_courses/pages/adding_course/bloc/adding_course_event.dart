part of 'adding_course_bloc.dart';

abstract class AddingCourseEvent {}

class FetchMasterData extends AddingCourseEvent {
  FetchMasterData();
}

class PickThumbnailImage extends AddingCourseEvent {
  final File? thumbnail;

  PickThumbnailImage(this.thumbnail);
}

class WhatYouWillLearnQuantity extends AddingCourseEvent {
  final int count;

  WhatYouWillLearnQuantity(this.count);
}

class RequirementQuantity extends AddingCourseEvent {
  final int count;

  RequirementQuantity(this.count);
}

class IncludeQuantity extends AddingCourseEvent {
  final int count;

  IncludeQuantity(this.count);
}

class AddLesson extends AddingCourseEvent {
  AddLesson();
}

class RemoveLesson extends AddingCourseEvent {
  final int index;

  RemoveLesson(this.index);
}

class PickLessonVideo extends AddingCourseEvent {
  final FlickManager? video;
  final File? file;
  final int index;

  PickLessonVideo(this.video, this.file, this.index);
}

class InitialSetup extends AddingCourseEvent {
  InitialSetup();
}
