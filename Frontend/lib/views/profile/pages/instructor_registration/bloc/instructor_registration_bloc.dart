import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'instructor_registration_event.dart';
part 'instructor_registration_state.dart';

class InstructorRegistrationBloc
    extends Bloc<InstructorRegistrationEvent, InstructorRegistrationState> {
  InstructorRegistrationBloc() : super(const InstructorRegistrationState()) {
    on<AboutQuantityEvent>((event, emit) {
      aboutQuantityEvent(event, emit);
    });
    on<QualificationQuantityEvent>((event, emit) {
      qualificationQuantityEvent(event, emit);
    });
    on<ExperienceQuantityEvent>((event, emit) {
      experienceQuantityEvent(event, emit);
    });
  }

  void aboutQuantityEvent(
      AboutQuantityEvent event, Emitter<InstructorRegistrationState> emit) {
    emit(state.copyWith(aboutQuantity: event.aboutQuantity));
  }

  void qualificationQuantityEvent(QualificationQuantityEvent event,
      Emitter<InstructorRegistrationState> emit) {
    emit(state.copyWith(qualificationQuantity: event.qualificationQuantity));
  }

  void experienceQuantityEvent(ExperienceQuantityEvent event,
      Emitter<InstructorRegistrationState> emit) {
    emit(state.copyWith(experienceQuantity: event.experienceQuantity));
  }
}
