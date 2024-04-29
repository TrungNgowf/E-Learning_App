import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'created_courses_event.dart';
part 'created_courses_state.dart';

class CreatedCoursesBloc extends Bloc<CreatedCoursesEvent, CreatedCoursesState> {
  CreatedCoursesBloc() : super(CreatedCoursesInitial()) {
    on<CreatedCoursesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
