import 'package:e_learning_app/models/course/course_category.dart';
import 'package:e_learning_app/models/course/course_detail.dart';
import 'package:e_learning_app/models/course/course_library.dart';
import 'package:e_learning_app/models/course/course_list_for_instructor.dart';
import 'package:e_learning_app/models/course/course_preview_for_instructor.dart';
import 'package:e_learning_app/services/course/course_service.dart';

class CourseRepository {
  Future<List<CourseCategory>> getCourseCategories() async {
    try {
      var response = await CourseService.getCourseCategories();
      if (response.statusCode == 200) {
        return courseCategoryFromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future createCourse(Map<String, dynamic> map) async {
    try {
      var response = await CourseService.createCourse(map);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CourseListForInstructor>> getCoursesForInstructor() async {
    try {
      var response = await CourseService.getCoursesForInstructor();
      if (response.statusCode == 200) {
        return courseListForInstructorFromJson(response.data as List);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CoursePreviewForInstructor> getCoursePreviewForInstructor(
      int courseId) async {
    try {
      var response =
          await CourseService.getCoursePreviewForInstructor(courseId);
      if (response.statusCode == 200) {
        return CoursePreviewForInstructor.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CourseDetailDto> getCourseDetail(int courseId) async {
    try {
      var response = await CourseService.getCourseDetail(courseId);
      if (response.statusCode == 200) {
        return CourseDetailDto.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future likeCourse(int courseId) async {
    try {
      var response = await CourseService.likeCourse(courseId);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future unlikeCourse(int courseId) async {
    try {
      var response = await CourseService.unLikeCourse(courseId);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future enrollCourse(int courseId) async {
    try {
      var response = await CourseService.enrollCourse(courseId);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CourseLibraryDto>> getListEnrolledCourses() async {
    try {
      var response = await CourseService.getListEnrolledCourses();
      if (response.statusCode == 200) {
        return courseLibraryDtoFromJson(response.data as List);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CourseLibraryDto>> getListFavoriteCourses() async {
    try {
      var response = await CourseService.getListFavoriteCourses();
      if (response.statusCode == 200) {
        return courseLibraryDtoFromJson(response.data as List);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
