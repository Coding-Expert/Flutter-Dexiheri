
abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators{
final StringValidator emailValidator = NonEmptyStringValidator();
final StringValidator passwordValidator = NonEmptyStringValidator();
final String invalidEmailErrorText = 'To email δεν μπορεί να είναι κενό';
final String invalidPasswordErrorText = 'To password δεν μπορεί να είναι κενό';
}