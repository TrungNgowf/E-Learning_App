import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<UsernameEvent>((event, emit) => usernameEvent(event, emit));
    on<EmailEvent>((event, emit) => emailEvent(event, emit));
    on<PasswordEvent>((event, emit) => passwordEvent(event, emit));
    on<ConfirmPasswordEvent>(
        (event, emit) => confirmPasswordEvent(event, emit));
  }

  void usernameEvent(UsernameEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void emailEvent(EmailEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void passwordEvent(PasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void confirmPasswordEvent(
      ConfirmPasswordEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }
}
