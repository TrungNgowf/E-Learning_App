import 'package:bloc/bloc.dart';
import 'package:e_learning_app/common/custom_toast.dart';
import 'package:e_learning_app/models/course/course_detail.dart';
import 'package:e_learning_app/repositories/course/course_repository.dart';
import 'package:e_learning_app/repositories/user/user_repository.dart';
import 'package:e_learning_app/utils/export.dart';

part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  CourseRepository repository = CourseRepository();
  UserRepository userRepository = UserRepository();

  CourseDetailCubit() : super(CourseDetailInitial());

  late CourseDetailDto course;
  var accountBalance = 0.0;

  Future getCourseDetail(int courseId) async {
    emit(CourseDetailLoading());
    try {
      CourseDetailDto response = await repository.getCourseDetail(courseId);
      course = response;
      emit(CourseDetailLoaded(course));
    } catch (e) {
      emit(CourseDetailError(e.toString()));
    }
  }

  Future likeCourse(int courseId) async {
    try {
      await repository.likeCourse(courseId).then((value) {
        if (value) {
          emit(CourseDetailLoaded(course.copyWith(isLiked: true)));
        } else {
          CustomToast.error("Failed to like course", value.statusMessage);
        }
      });
    } catch (e) {
      CustomToast.error("Failed to like course", e.toString());
    }
  }

  Future unlikeCourse(int courseId) async {
    try {
      await repository.unlikeCourse(courseId).then((value) {
        if (value) {
          emit(CourseDetailLoaded(course.copyWith(isLiked: false)));
        } else {
          CustomToast.error("Failed to unlike course", value.statusMessage);
        }
      });
    } catch (e) {
      CustomToast.error("Failed to unlike course", e.toString());
    }
  }

  Future<double> getAccountBalance() async {
    try {
      double response = await userRepository.getAccountBalance();
      accountBalance = response;
      return response;
    } catch (e) {
      CustomToast.error("Failed to get account balance", e.toString());
      throw Exception(e);
    }
  }

  Future enrollCourse(int courseId) async {
    try {
      await repository.enrollCourse(courseId).then((value) {
        if (value) {
          emit(CourseDetailLoaded(course.copyWith(isPurchased: true)));
          return true;
        } else {
          CustomToast.error("Failed to enroll course", "");
          return false;
        }
      });
    } catch (e) {
      CustomToast.error("Failed to like course", e.toString());
    }
  }
}
