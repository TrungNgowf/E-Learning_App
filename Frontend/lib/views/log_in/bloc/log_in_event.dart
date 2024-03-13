abstract class LogInEvent {
  const LogInEvent();
}

class EmailEvent extends LogInEvent {
  final String email;

  EmailEvent({required this.email});
}

class PasswordEvent extends LogInEvent {
  final String password;

  PasswordEvent({required this.password});
}
