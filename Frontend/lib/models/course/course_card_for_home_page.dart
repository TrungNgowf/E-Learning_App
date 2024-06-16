// To parse this JSON data, do
//
//     final courseCardForHomePage = courseCardForHomePageFromJson(jsonString);

import 'dart:convert';

List<CourseCardForHomePage> courseCardForHomePageFromJson(List str) =>
    List<CourseCardForHomePage>.from(
        str.map((x) => CourseCardForHomePage.fromJson(x)));

String courseCardForHomePageToJson(List<CourseCardForHomePage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseCardForHomePage {
  int id;
  String title;
  String thumbnail;
  double coursePrice;
  List<String> categories;
  double? courseScore;
  String author;

  CourseCardForHomePage({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.coursePrice,
    required this.categories,
    this.courseScore,
    required this.author,
  });

  factory CourseCardForHomePage.fromJson(Map<String, dynamic> json) =>
      CourseCardForHomePage(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        coursePrice: json["coursePrice"].toDouble(),
        categories: List<String>.from(json["categories"].map((x) => x)),
        courseScore: json["courseScore"]?.toDouble(),
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "coursePrice": coursePrice,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "courseScore": courseScore,
        "author": author,
      };
}
