import 'package:formz/formz.dart';

// Define input validation errors
enum EmailInputError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailInputError> {
  static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isPure || isValid) {
      return null;
    }

    return switch (error) {
      EmailInputError.empty => "Email can't be empty",
      EmailInputError.invalid => "Email is invalid",
      _ => null,
    };
  }

  // Override validator to handle validating a given input value.
  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return EmailInputError.empty;
    }
    if (EmailInput.emailRegExp.hasMatch(value) == false) {
      return EmailInputError.invalid;
    }
    return null;
  }
}
