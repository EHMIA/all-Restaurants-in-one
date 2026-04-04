abstract class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  SignUpButtonPressed({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });
}
