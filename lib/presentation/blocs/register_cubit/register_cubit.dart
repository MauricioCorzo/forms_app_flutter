import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/infrastructure/inputs/password.dart';
import 'package:forms_app/infrastructure/inputs/username.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmitted() {
    print("Form submitted: ${state}");
  }

  void usernameChanged(String value) {
    final username = UsernameInput.dirty(value: value);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([
        username,
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value: value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.username]),
    ));
  }
}
