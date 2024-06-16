// To parse this JSON data, do
//
//     final coursePreviewForInstructor = coursePreviewForInstructorFromJson(jsonString);

import 'dart:convert';

import 'course_detail.dart';

CoursePreviewForInstructor coursePreviewForInstructorFromJson(String str) =>
    CoursePreviewForInstructor.fromJson(json.decode(str));

String coursePreviewForInstructorToJson(CoursePreviewForInstructor data) =>
    json.encode(data.toJson());

class CoursePreviewForInstructor {
  String title;
  String description;
  String author;
  List<String> categories;
  double coursePrice;
  String thumbnail;
  String requirements;
  String whatYouWillLearn;
  String includes;
  List<Lesson> lessons;
  DateTime creationTime;
  int totalDuration;

  CoursePreviewForInstructor({
    required this.title,
    required this.description,
    required this.author,
    required this.categories,
    required this.coursePrice,
    required this.thumbnail,
    required this.requirements,
    required this.whatYouWillLearn,
    required this.includes,
    required this.lessons,
    required this.creationTime,
    required this.totalDuration,
  });

  factory CoursePreviewForInstructor.fromJson(Map<String, dynamic> json) =>
      CoursePreviewForInstructor(
        title: json["title"],
        description: json["description"],
        author: json["author"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        coursePrice: json["coursePrice"],
        thumbnail: json["thumbnail"],
        requirements: json["requirements"],
        whatYouWillLearn: json["whatYouWillLearn"],
        includes: json["includes"],
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        creationTime: DateTime.parse(json["creationTime"].toString()),
        totalDuration: json["totalDuration"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "author": author,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "coursePrice": coursePrice,
        "thumbnail": thumbnail,
        "requirements": requirements,
        "whatYouWillLearn": whatYouWillLearn,
        "includes": includes,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
        "creationTime":
            "${creationTime.year.toString().padLeft(4, '0')}-${creationTime.month.toString().padLeft(2, '0')}-${creationTime.day.toString().padLeft(2, '0')}",
        "totalDuration": totalDuration,
      };
}
