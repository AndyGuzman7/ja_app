bool isValidName(String text) {
  return RegExp(r"^[a-zA-ZñÑ]+$").hasMatch(text);
}

bool isValidPhone(String text) {
  return RegExp(r"^(?:[+0]{0,9})?[0-9]{6,15}$").hasMatch(text);
}
