// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  int userId;
  String firebaseUid;
  String username;
  String email;
  String accessToken;
  String refreshToken;
  List<String> roles;

  AuthResponse({
    required this.userId,
    required this.firebaseUid,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.roles,
  });

  AuthResponse copyWith({
    int? userId,
    String? firebaseUid,
    String? username,
    String? email,
    String? accessToken,
    String? refreshToken,
    List<String>? roles,
  }) =>
      AuthResponse(
        userId: userId ?? this.userId,
        firebaseUid: firebaseUid ?? this.firebaseUid,
        username: username ?? this.username,
        email: email ?? this.email,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        roles: roles ?? this.roles,
      );

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["userId"],
        firebaseUid: json["firebaseUID"],
        username: json["username"],
        email: json["email"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firebaseUID": firebaseUid,
        "username": username,
        "email": email,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}
