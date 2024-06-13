import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  ChattingBloc() : super(ChattingInitial()) {
    on<ChattingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
