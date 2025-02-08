import 'package:flutter/cupertino.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/services/s_auth.dart';
import 'package:hather_app/src/utils/di/services_locator.dart';
import 'package:provider/provider.dart';

class CUser extends ChangeNotifier{
  static CUser get(BuildContext context) =>
      Provider.of<CUser>(context, listen: false);
  final sAuth = getIt<SAuth>();
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }
  void logout() {
    sAuth.logout();
    user=null;
    notifyListeners();
  }

  void initial() {
    _user = sAuth.getUserData();
    notifyListeners();
  }
}