part of 'instructor_registration_bloc.dart';

@immutable
class InstructorRegistrationState {
  final int aboutQuantity;
  final int qualificationQuantity;
  final int experienceQuantity;

  const InstructorRegistrationState(
      {this.aboutQuantity = 1,
      this.qualificationQuantity = 1,
      this.experienceQuantity = 1});

  InstructorRegistrationState copyWith(
      {int? aboutQuantity,
      int? qualificationQuantity,
      int? experienceQuantity}) {
    return InstructorRegistrationState(
        aboutQuantity: aboutQuantity ?? this.aboutQuantity,
        qualificationQuantity:
            qualificationQuantity ?? this.qualificationQuantity,
        experienceQuantity: experienceQuantity ?? this.experienceQuantity);
  }
}
