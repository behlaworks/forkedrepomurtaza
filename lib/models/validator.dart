class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateAge({required String? age}) {
    if (age == null) {
      return null;
    }
    if (age.isEmpty) {
      return 'Age cannot be empty.';
    }
    try{
    if(int.parse(age) > 100 || int.parse(age) < 5){
      return 'Enter a valid age';
    }} catch(e){
      return 'Enter a valid age';
    }

    return null;
  }
  static String? validateReferral({required String? code}) {
    if (code == null) {
      return null;
    }
    if(code.isEmpty){
      return null;
    }
    if (code.length < 15) {
      return 'invalid referral code';
    }

    return null;
  }
  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.length < 8) {
      return 'min. 8 characters for password ';
    }

    return null;
  }
  static String? validatePasswordAgain({required String? current, required String? previous}) {
    if (current == null) {
      return null;
    }
    if (current.isEmpty){
      return 'Cannot be empty';
    }
    if (current != previous) {
      return 'passwords do not match.';
    }

    return null;
  }
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

}