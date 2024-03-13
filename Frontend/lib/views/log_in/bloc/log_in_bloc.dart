import 'package:bloc/bloc.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_event.dart';
import 'package:e_learning_app/views/log_in/bloc/log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(const LogInState()) {
    on<EmailEvent>(emailEvent);
    on<PasswordEvent>(passwordEvent);
  }

  void emailEvent(EmailEvent event, Emitter<LogInState> emit) {
    emit(state.copyWith(email: state.email));
  }

  void passwordEvent(PasswordEvent event, Emitter<LogInState> emit) {
    emit(state.copyWith(password: state.password));
  }
}
