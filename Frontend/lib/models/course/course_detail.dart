// To parse this JSON data, do
//
//     final courseDetailDto = courseDetailDtoFromJson(jsonString);

import 'dart:convert';

CourseDetailDto courseDetailDtoFromJson(String str) =>
    CourseDetailDto.fromJson(json.decode(str));

String courseDetailDtoToJson(CourseDetailDto data) =>
    json.encode(data.toJson());

class CourseDetailDto {
  int id;
  String title;
  String description;
  Author author;
  List<String> categories;
  double coursePrice;
  String thumbnail;
  String requirements;
  String whatYouWillLearn;
  String includes;
  List<Lesson> lessons;
  int totalDuration;
  DateTime creationTime;
  bool isPurchased;
  bool isLiked;

  CourseDetailDto({
    required this.id,
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
    required this.totalDuration,
    required this.creationTime,
    required this.isPurchased,
    required this.isLiked,
  });

  CourseDetailDto copyWith({
    int? id,
    String? title,
    String? description,
    Author? author,
    List<String>? categories,
    double? coursePrice,
    String? thumbnail,
    String? requirements,
    String? whatYouWillLearn,
    String? includes,
    List<Lesson>? lessons,
    int? totalDuration,
    DateTime? creationTime,
    bool? isPurchased,
    bool? isLiked,
  }) =>
      CourseDetailDto(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        author: author ?? this.author,
        categories: categories ?? this.categories,
        coursePrice: coursePrice ?? this.coursePrice,
        thumbnail: thumbnail ?? this.thumbnail,
        requirements: requirements ?? this.requirements,
        whatYouWillLearn: whatYouWillLearn ?? this.whatYouWillLearn,
        includes: includes ?? this.includes,
        lessons: lessons ?? this.lessons,
        totalDuration: totalDuration ?? this.totalDuration,
        creationTime: creationTime ?? this.creationTime,
        isPurchased: isPurchased ?? this.isPurchased,
        isLiked: isLiked ?? this.isLiked,
      );

  factory CourseDetailDto.fromJson(Map<String, dynamic> json) =>
      CourseDetailDto(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        coursePrice: json["coursePrice"].toDouble(),
        thumbnail: json["thumbnail"],
        requirements: json["requirements"],
        whatYouWillLearn: json["whatYouWillLearn"],
        includes: json["includes"],
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        totalDuration: json["totalDuration"],
        creationTime: DateTime.parse(json["creationTime"]),
        isPurchased: json["isPurchased"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "author": author.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "coursePrice": coursePrice,
        "thumbnail": thumbnail,
        "requirements": requirements,
        "whatYouWillLearn": whatYouWillLearn,
        "includes": includes,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
        "totalDuration": totalDuration,
        "creationTime": creationTime.toIso8601String(),
        "isPurchased": isPurchased,
        "isLiked": isLiked,
      };
}

class Author {
  int id;
  String name;
  String profilePicture;
  String contactInfo;
  int totalCourses;

  Author({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.contactInfo,
    required this.totalCourses,
  });

  Author copyWith({
    int? id,
    String? name,
    String? profilePicture,
    String? contactInfo,
    int? totalCourses,
  }) =>
      Author(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePicture: profilePicture ?? this.profilePicture,
        contactInfo: contactInfo ?? this.contactInfo,
        totalCourses: totalCourses ?? this.totalCourses,
      );

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        contactInfo: json["contactInfo"],
        totalCourses: json["totalCourses"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profilePicture": profilePicture,
        "contactInfo": contactInfo,
        "totalCourses": totalCourses,
      };
}

class Lesson {
  String title;
  String description;
  String videoUrl;
  int duration;

  Lesson({
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.duration,
  });

  Lesson copyWith({
    String? title,
    String? description,
    String? videoUrl,
    int? duration,
  }) =>
      Lesson(
        title: title ?? this.title,
        description: description ?? this.description,
        videoUrl: videoUrl ?? this.videoUrl,
        duration: duration ?? this.duration,
      );

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        title: json["title"],
        description: json["description"],
        videoUrl: json["videoUrl"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "videoUrl": videoUrl,
        "duration": duration,
      };
}
