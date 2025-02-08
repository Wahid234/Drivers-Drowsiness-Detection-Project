import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/services/s_auth.dart';
import 'package:hather_app/src/utils/di/services_locator.dart';
import 'package:provider/provider.dart';

class CAuth extends ChangeNotifier {
  static CAuth get(BuildContext context) =>
      Provider.of<CAuth>(context, listen: false);
  final sAuth = getIt<SAuth>();

  Future<Either> login(String email,String password) async {
    try {
      // Call the login method from SAuth service
      final result = await sAuth.login(email, password);
      return result;
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either> verify(String code) async {
    try {
      // Call the verify method from SAuth service
      final result = await sAuth.verify(code);
      return result;
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either> register(User user) async {
    try {
      // Call the register method from SAuth service
      final result = await sAuth.register(user);
      return result;
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
