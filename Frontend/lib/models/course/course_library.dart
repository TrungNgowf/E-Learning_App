// To parse this JSON data, do
//
//     final courseLibraryDto = courseLibraryDtoFromJson(jsonString);

import 'dart:convert';

List<CourseLibraryDto> courseLibraryDtoFromJson(List str) =>
    List<CourseLibraryDto>.from(str.map((x) => CourseLibraryDto.fromJson(x)));

String courseLibraryDtoToJson(List<CourseLibraryDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseLibraryDto {
  int id;
  String title;
  String author;
  List<String> categories;
  String thumbnail;
  double coursePrice;
  DateTime creationTime;

  CourseLibraryDto({
    required this.id,
    required this.title,
    required this.author,
    required this.categories,
    required this.thumbnail,
    required this.coursePrice,
    required this.creationTime,
  });

  CourseLibraryDto copyWith({
    int? id,
    String? title,
    String? author,
    List<String>? categories,
    String? thumbnail,
    double? coursePrice,
    DateTime? creationTime,
  }) =>
      CourseLibraryDto(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        categories: categories ?? this.categories,
        thumbnail: thumbnail ?? this.thumbnail,
        coursePrice: coursePrice ?? this.coursePrice,
        creationTime: creationTime ?? this.creationTime,
      );

  factory CourseLibraryDto.fromJson(Map<String, dynamic> json) =>
      CourseLibraryDto(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        thumbnail: json["thumbnail"],
        coursePrice: json["coursePrice"].toDouble(),
        creationTime: DateTime.parse(json["creationTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "thumbnail": thumbnail,
        "coursePrice": coursePrice,
        "creationTime": creationTime.toIso8601String(),
      };
}
