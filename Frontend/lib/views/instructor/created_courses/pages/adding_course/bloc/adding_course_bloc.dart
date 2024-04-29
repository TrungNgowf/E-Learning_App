import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_learning_app/constants/enum.dart';
import 'package:e_learning_app/models/course/course_category.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';

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
}
