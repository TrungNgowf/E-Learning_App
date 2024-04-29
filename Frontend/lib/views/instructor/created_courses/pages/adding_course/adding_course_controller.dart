import 'dart:io';

import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/utils/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/adding_course_bloc.dart';

class AddingCourseController {
  AddingCourseController();

  final ImagePicker picker = ImagePicker();
  CourseRepository repository = CourseRepository();

  Future pickThumbnailImage() async {
    final returnedImage = await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      Get.context!
          .read<AddingCourseBloc>()
          .add(PickThumbnailImage(File(returnedImage.path)));
    }
  }
}
