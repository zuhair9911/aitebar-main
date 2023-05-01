class Validators {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != password) {
      return 'Password does not match';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value) ? null : 'Please enter a valid email address';
  }

  bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value);
  }

  bool isValidPassword(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (value.length < 8) {
      return false;
    }
    return true;
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    } else if (value.length < 10) {
      return 'Title must be at least 10 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    } else if (value.length < 3) {
      return 'Amount must be at least 3 characters';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    } else if (value.length < 10) {
      return 'Address must be at least 10 characters';
    }
    return null;
  }

  String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact Number is required';
    } else if (value.length < 10) {
      return 'Contact Number must be at least 10 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    } else if (value.length < 100) {
      return 'Description must be at least 100 characters';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is required';
    }
    return null;
  }

  String? validateAccountTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account title is required';
    }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account Number is required';
    }
    return null;
  }

  String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank name is required';
    }
    return null;
  }
}
