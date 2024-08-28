class ValidatedLoginFunction {
  static String? validateEmail(String? value, String message) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    if (value!.trim().isEmpty) {
      return message;
    }
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  static String? validatePassword(String? value, String message) {
    if (value!.trim().length <= 7) {
      return message;
    } else {
      return null;
    }
  }
}
