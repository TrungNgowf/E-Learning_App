// To parse this JSON data, do
//
//     final courseListForInstructor = courseListForInstructorFromJson(jsonString);

import 'dart:convert';

List<CourseListForInstructor> courseListForInstructorFromJson(List str) =>
    List<CourseListForInstructor>.from(
        str.map((x) => CourseListForInstructor.fromJson(x)));

String courseListForInstructorToJson(List<CourseListForInstructor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseListForInstructor {
  int id;
  String title;
  String thumbnail;
  DateTime creationTime;
  double coursePrice;
  List<String> categories;

  CourseListForInstructor({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.creationTime,
    required this.coursePrice,
    required this.categories,
  });

  factory CourseListForInstructor.fromJson(Map<String, dynamic> json) =>
      CourseListForInstructor(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        creationTime: DateTime.parse(json["creationTime"]),
        coursePrice: json["coursePrice"],
        categories: List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "creationTime": creationTime.toIso8601String(),
        "coursePrice": coursePrice,
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}
