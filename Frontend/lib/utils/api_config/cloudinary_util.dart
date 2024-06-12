import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryUtil {
  static const String cloudName = 'sofiathefck';
  static const String uploadPreset = 'e_learning';
  static var cloudinary = CloudinaryPublic(cloudName, uploadPreset);
  static const String courseLessonsFolder = 'e_learning/course_lessons';
  static const String courseThumbnailsFolder = 'e_learning/course_thumbnails';
  static const String courseResourcesFolder = 'e_learning/course_resources';
}
