class Validator {
  static String? email(String? value) {
    if (value == null) return null;

    String pattern =
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Input harus email";
    } else {
      return null;
    }
  }

  static String? password(String? value) {
    if (value == null) return null;

    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Minimal harus 8 karakter";
    } else {
      return null;
    }
  }

  static String? name(String? value) {
    if (value == null) return null;

    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Tolong masukan nama";
    } else {
      return null;
    }
  }

  static String? number(String? value) {
    if (value == null) return null;

    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Tolong masukan angka";
    } else {
      return null;
    }
  }

  static String? amount(String? value) {
    if (value == null) return null;

    Pattern pattern = r'^\d+$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Tolong masukan hanya angka";
    } else {
      return null;
    }
  }

  static String? notEmpty(String? value) {
    if (value?.isEmpty ?? true) return "Pertanyaan ini harus diisi";
    return null;
  }
}
