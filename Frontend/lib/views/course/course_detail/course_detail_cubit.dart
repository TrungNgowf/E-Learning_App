import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  CourseDetailCubit() : super(CourseDetailInitial());
}
