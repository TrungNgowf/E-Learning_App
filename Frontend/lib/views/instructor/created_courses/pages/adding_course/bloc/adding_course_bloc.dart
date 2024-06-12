import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_learning_app/constants/enum.dart';
import 'package:e_learning_app/models/course/course_category.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:flick_video_player/flick_video_player.dart';

part 'adding_course_event.dart';
part 'adding_course_state.dart';

class AddingCourseBloc extends Bloc<AddingCourseEvent, AddingCourseState> {
  CourseRepository repository = CourseRepository();

  AddingCourseBloc() : super(const AddingCourseState()) {
    on<FetchMasterData>((event, emit) async {
      await fetchMasterData(event, emit);
    });
    on<PickThumbnailImage>((event, emit) {
      pickThumbnailImage(event, emit);
    });
    on<WhatYouWillLearnQuantity>((event, emit) {
      whatYouWillLearnQuantity(event, emit);
    });
    on<RequirementQuantity>((event, emit) {
      requirementQuantity(event, emit);
    });
    on<IncludeQuantity>((event, emit) {
      includeQuantity(event, emit);
    });
    on<AddLesson>((event, emit) {
      addLesson(event, emit);
    });
    on<RemoveLesson>((event, emit) {
      removeLesson(event, emit);
    });
    on<PickLessonVideo>((event, emit) {
      pickLessonVideo(event, emit);
    });
    on<InitialSetup>((event, emit) {
      emit(state.initialSetup());
    });
  }

  Future fetchMasterData(
      FetchMasterData event, Emitter<AddingCourseState> emit) async {
    await repository.getCourseCategories().then((courseCategories) {
      emit(state.copyWith(
          apiStatus: ApiStatus.success, courseCategories: courseCategories));
    }).catchError((e) {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    });
  }

  void pickThumbnailImage(
      PickThumbnailImage event, Emitter<AddingCourseState> emit) {
    if (event.thumbnail == null) {
      emit(state.removeThumbnail());
    } else {
      emit(state.copyWith(thumbnail: event.thumbnail));
    }
  }

  void whatYouWillLearnQuantity(
      WhatYouWillLearnQuantity event, Emitter<AddingCourseState> emit) {
    emit(state.copyWith(whatYouWillLearnCount: event.count));
  }

  void requirementQuantity(
      RequirementQuantity event, Emitter<AddingCourseState> emit) {
    emit(state.copyWith(requirementCount: event.count));
  }

  void includeQuantity(IncludeQuantity event, Emitter<AddingCourseState> emit) {
    emit(state.copyWith(includeCount: event.count));
  }

  void addLesson(AddLesson event, Emitter<AddingCourseState> emit) {
    emit(state.copyWith(
        lessonVideos: List.from(state.lessonVideos)..add(null),
        lessonFiles: List.from(state.lessonFiles)..add(null)));
  }

  void removeLesson(RemoveLesson event, Emitter<AddingCourseState> emit) {
    emit(state.copyWith(
        lessonVideos: List.from(state.lessonVideos)..removeAt(event.index),
        lessonFiles: List.from(state.lessonFiles)..removeAt(event.index)));
  }

  void pickLessonVideo(PickLessonVideo event, Emitter<AddingCourseState> emit) {
    final lessonVideos = List<FlickManager?>.from(state.lessonVideos);
    lessonVideos[event.index] = event.video;
    final lessonFiles = List<File?>.from(state.lessonFiles);
    lessonFiles[event.index] = event.file;
    emit(state.copyWith(lessonVideos: lessonVideos, lessonFiles: lessonFiles));
  }
}
