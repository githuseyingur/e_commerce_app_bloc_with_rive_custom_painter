extension ValidateRegexExtension on String {
  bool get isEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool get isPhone =>
      RegExp(r'^[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$')
          .hasMatch(this);

  bool get isUrl =>
      RegExp(r'^(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+')
          .hasMatch(this);
  bool get isDate => RegExp(r'^[0-9]{4}-[0-9]{2}-[0-9]{2}$').hasMatch(this);
  bool get isTime => RegExp(r'^[0-9]{2}:[0-9]{2}:[0-9]{2}$').hasMatch(this);
  bool get isDateTime =>
      RegExp(r'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
          .hasMatch(this);
  bool get isNumber => RegExp(r'^[0-9]+$').hasMatch(this);
  bool get isInteger => RegExp(r'^[0-9]+$').hasMatch(this);
  bool get isDouble => RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(this);
  bool get isNameSurname => RegExp(r'^[a-zA-Z]+$').hasMatch(this);
//r'^[a-zA-ZĞÜŞİÖÇğüşıöç\s]+$')

  // TC IDENTITY NUMBER
  bool isTC(String input) {
    RegExp regex = RegExp(
        r'^[1-9]{1}[0-9]{9}[02468]{1}$'); // Regular Expression for TC IDENTITY NUMBER
    if (!regex.hasMatch(input)) return false;

    int sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(input.substring(i, i + 1));
    }
    int digit11 = sum % 10;
    print("digit11 : $digit11");

    int oddSum = 0;
    for (int i = 0; i < 9; i = i + 2) {
      // 0,2,4,6,8 (1,3,5,7,9)
      oddSum += int.parse(input.substring(i, i + 1));
    }
    int evenSum = 0;
    for (int i = 1; i < 9; i = i + 2) {
      //1,3,5,7  (2,4,6,8)
      evenSum += int.parse(input.substring(i, i + 1));
    }
    int digit10 = (oddSum * 7) - evenSum;
    digit10 = digit10 % 10;
    print("digit10 : $digit10");

    if (digit11 != int.parse(input.substring(10, 11)) ||
        digit10 != int.parse(input.substring(9, 10))) {
      return false;
    }
    return true;
  }

  // PASSWORD
  bool isPassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%^]).{8,}$');
    return regex.hasMatch(password);
  }

  //* RE-PASSWORD
  bool isRepeartPassword(String password, String confirmPassword) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%^]).{8,}$');
    if (!regex.hasMatch(password)) {
      return false;
    }
    if (password != confirmPassword) {
      return false;
    }
    return true;
  }
}
