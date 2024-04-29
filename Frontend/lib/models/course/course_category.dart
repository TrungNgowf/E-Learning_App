// To parse this JSON data, do
//
//     final courseCategory = courseCategoryFromJson(jsonString);

import 'dart:convert';

List<CourseCategory> courseCategoryFromJson(List str) =>
    List<CourseCategory>.from(str.map((x) => CourseCategory.fromJson(x)));

String courseCategoryToJson(List<CourseCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseCategory {
  int id;
  String title;
  String? description;

  CourseCategory({
    required this.id,
    required this.title,
    this.description,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) => CourseCategory(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
