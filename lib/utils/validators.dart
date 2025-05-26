String? emailValidator(String? value) {
  if (value == null ||
      !RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
      ).hasMatch(value)) {
    return 'Please enter a valid email.';
  }
  return null;
}

String? passValidator(String? value) {
  if (value == null ||
      !RegExp(
        r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$",
      ).hasMatch(value)) {
    return 'Password must have:\n'
        '- At least 6 characters\n'
        '- An uppercase letter\n'
        '- A lowercase letter\n'
        '- A digit\n'
        '- A special character';
  }
  return null;
}
