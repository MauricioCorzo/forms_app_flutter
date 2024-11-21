import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputError { empty, length }

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isPure || isValid) {
      return null;
    }

    return switch (error) {
      PasswordInputError.empty => "Password can't be empty",
      PasswordInputError.length =>
        "Password must be at least 8 characters long",
      _ => null,
    };
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty;
    }
    if (value.length < 8) {
      return PasswordInputError.length;
    }
    return null;
  }
}
