import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/infrastructure/inputs/email.dart';
import 'package:forms_app/infrastructure/inputs/password.dart';
import 'package:forms_app/infrastructure/inputs/username.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmitted() {
    emit(state.copyWith(
      formStatus: FormStatus.submitting,
      username: UsernameInput.dirty(value: state.username.value),
      email: EmailInput.dirty(value: state.email.value),
      password: PasswordInput.dirty(value: state.password.value),
      isValid: Formz.validate([
        state.username,
        state.email,
        state.password,
      ]),
    ));
    print("Form submitted: ${state}");
  }

  void usernameChanged(String value) {
    final username = UsernameInput.dirty(value: value);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([
        username,
        state.password,
        state.email,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value: value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.password,
        state.username,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value: value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([
        password,
        state.username,
        state.email,
      ]),
    ));
  }
}
