import 'package:flutter/material.dart';
import 'package:test_application/screen/home.dart';
import 'validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpValidation with ChangeNotifier {
  ValidationItem _Name = ValidationItem(null, null);
  ValidationItem _Email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

// Getters
  ValidationItem get Name => _Name;
  ValidationItem get Email => _Email;
  ValidationItem get Password => _password;
  bool get isValid {
    if (Name.value != null && Email.value != null && Password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  // Setters
  void changeName(String firstName) {
    if (firstName.length >= 3) {
      _Name = ValidationItem(firstName, null);
    } else {
      _Name = ValidationItem(null, "Must be three characters or more");
    }

    notifyListeners();
  }

  void changeEmail(String Email) {
    if (Email.length >= 6) {
      _Email = ValidationItem(Email, null);
    } else {
      _Email = ValidationItem(null, "Must be six characters or more");
    }

    notifyListeners();
  }

  void changePassword(String password) {
    if (password.length >= 6) {
      _password = ValidationItem(password, null);
    } else {
      _password = ValidationItem(null, "Must be six  characters or more");
    }

    notifyListeners();
  }

  void submitData() async {
    print(
        'First Name: ${Name.value}, Last Name: ${Email.value}, Password: ${Password.value}');
  }
}
