import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'streaming_event.dart';
part 'streaming_state.dart';

class StreamingBloc extends Bloc<StreamingEvent, StreamingState> {
  StreamingBloc() : super(StreamingInitial()) {
    on<StreamingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
