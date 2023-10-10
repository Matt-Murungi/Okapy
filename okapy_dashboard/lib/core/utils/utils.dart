replaceErrorStringBrackets(error) {
  return error.replaceAll("[", "").replaceAll("]", "");
}

replaceErrorStringCurlyBrackets(error) {
  return error.replaceAll("{", "").replaceAll("}", "");
}
