// class for login credentials
class LoginCredentials {
  String? email;
  String? password;
  String? get error {
    if (email == null || email!.isEmpty) {
      return 'Username is required';
    }
    if (password == null || password!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  set error(String? value) {
    error = value;
  }

  String? get validateUsername {
    if (email == null || email!.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? get validatePassword {
    if (password == null || password!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  LoginCredentials({
    this.email,
    this.password,
  });

  /// check if the credentials are valid
  bool get isValid {
    return isValidPassword && isValidUsername;
  }

  /// validate username
  bool get isValidUsername {
    bool isValid = false;
    isValid = password != null && password!.isNotEmpty;
    return isValid;
  }

  /// validate password
  bool get isValidPassword {
    bool isValid = false;
    isValid = password != null && password!.isNotEmpty;
    return isValid;
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'password': password,
    };
  } // to map

  // from map
  LoginCredentials.fromMap(Map<String, dynamic> map) {
    email = map['username'];

    password = map['password'];
  }
}

class SignUpCredentials {
  String? username;
  String? email;
  String? password;

  SignUpCredentials({
    this.username,
    this.email,
    this.password,
  });
  // to map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  } // to map

  // from map
  SignUpCredentials.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    email = map['email'];
    password = map['password'];
  }

  /// check if the credentials are valid
  bool get isValid {
    return isValidPassword && isValidUsername && isValidEmail;
  }

  /// validate username
  bool get isValidUsername {
    bool isValid = false;
    isValid = username != null && username!.isNotEmpty;
    return isValid;
  }

  /// validate password
  bool get isValidPassword {
    bool isValid = false;
    isValid = password != null && password!.isNotEmpty;
    return isValid;
  }

  /// validate email
  bool get isValidEmail {
    bool isValid = false;
    isValid = email != null && email!.isNotEmpty;
    return isValid;
  }
}
