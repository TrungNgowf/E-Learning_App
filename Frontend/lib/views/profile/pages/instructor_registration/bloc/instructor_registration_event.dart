part of 'instructor_registration_bloc.dart';

@immutable
sealed class InstructorRegistrationEvent {
  const InstructorRegistrationEvent();
}

class AboutQuantityEvent extends InstructorRegistrationEvent {
  final int aboutQuantity;

  const AboutQuantityEvent(this.aboutQuantity);
}

class QualificationQuantityEvent extends InstructorRegistrationEvent {
  final int qualificationQuantity;

  const QualificationQuantityEvent(this.qualificationQuantity);
}

class ExperienceQuantityEvent extends InstructorRegistrationEvent {
  final int experienceQuantity;

  const ExperienceQuantityEvent(this.experienceQuantity);
}
