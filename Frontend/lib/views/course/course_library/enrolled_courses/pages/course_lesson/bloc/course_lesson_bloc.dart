import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'course_lesson_event.dart';
part 'course_lesson_state.dart';

class CourseLessonBloc extends Bloc<CourseLessonEvent, CourseLessonState> {
  CourseLessonBloc() : super(CourseLessonInitial()) {
    on<CourseLessonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
