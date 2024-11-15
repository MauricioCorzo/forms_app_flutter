part of 'register_cubit.dart';

enum FormStatus { initial, valid, invalid, submitting }

class RegisterFormState extends Equatable {
  final UsernameInput username;
  final String email;
  final PasswordInput password;
  final FormStatus formStatus;
  final bool isValid;

  const RegisterFormState({
    this.username = const UsernameInput.pure(),
    this.email = '',
    this.password = const PasswordInput.pure(),
    this.formStatus = FormStatus.initial,
    this.isValid = false,
  });

  RegisterFormState copyWith({
    UsernameInput? username,
    String? email,
    PasswordInput? password,
    FormStatus? formStatus,
    bool? isValid,
  }) {
    return RegisterFormState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        username,
        email,
        password,
        formStatus,
        isValid,
      ];
}

final class RegisterInitial extends RegisterFormState {}
