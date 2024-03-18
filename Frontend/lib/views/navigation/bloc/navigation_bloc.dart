import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<NavigationPageChanged>((event, emit) => pageChanged(event, emit));
  }

  void pageChanged(NavigationPageChanged event, Emitter<NavigationState> emit) {
    emit(state.copyWith(event.page));
  }
}
