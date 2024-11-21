import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameInputError { empty, length, witheSpace }

// Extend FormzInput and provide the input type and error type.
class UsernameInput extends FormzInput<String, UsernameInputError> {
  // Call super.pure to represent an unmodified form input.
  const UsernameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isPure || isValid) {
      return null;
    }

    return switch (error) {
      UsernameInputError.empty => "Username can't be empty",
      UsernameInputError.length =>
        "Username must be at least 6 characters long",
      UsernameInputError.witheSpace =>
        "Username can't start or end with a whitespace",
      _ => null,
    };
  }

  // Override validator to handle validating a given input value.
  @override
  UsernameInputError? validator(String value) {
    if (value.isEmpty) {
      return UsernameInputError.empty;
    }
    if (value.trim().isEmpty) {
      return UsernameInputError.empty;
    }
    if (value.endsWith(" ") || value.startsWith(" ")) {
      return UsernameInputError.witheSpace;
    }
    if (value.length < 6) {
      return UsernameInputError.length;
    }
    return null;
  }
}
