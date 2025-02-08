import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/utils/local/preferences.dart';

class SAuth {
  final Preferences _preferences;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SAuth(this._preferences);

  Future<Either> login(String email, String password) async {
    try {
      // Check if user exists in Firestore
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      if (userSnapshot.docs.isEmpty) {
        return Left('User not found');
      }

      // User found, retrieve user data and save locally
      final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
      final user = User.fromMap(userData);
      await _saveUserDataLocally(user);
      return Right(user);
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either> verify(String code) async {
    try {
      // Generate fake verification codes from 1 to 6
      if (code == "123456") {
        return Right(1);
      }
    } catch (_) {}
    return Left('Error');
  }

  Future<Either> register(User user) async {
    try {
      // Check if user already exists
      QuerySnapshot existingUserSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get();
      if (existingUserSnapshot.docs.isNotEmpty) {
        return Left('User already exists');
      }

      // Register the user in Firestore
      await _firestore.collection('users').add(user.toMap());

      // Save user data locally
      await _saveUserDataLocally(user);

      return Right(user);
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<void> _saveUserDataLocally(User user) async {
    // Convert user object to JSON
    final userDataJson = jsonEncode(user.toMap());
    // Save JSON string to SharedPreferences
    await _preferences.insert('user', userDataJson);
  }

  User? getUserData() {
    try {
      final userDataString = _preferences.get('user');
      if (userDataString == null) return null;
      final userData = jsonDecode(userDataString.toString());
      final user = User.fromMap(userData);
      return user;
    } catch (e) {
      return null;
    }
  }

  void logout() =>_preferences.delete('user');
}
