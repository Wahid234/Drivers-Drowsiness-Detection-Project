import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:hather_app/src/models/message.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/services/s_auth.dart';
import 'package:hather_app/src/services/s_home.dart';
import 'package:hather_app/src/utils/di/services_locator.dart';
import 'package:provider/provider.dart';

class CHome extends ChangeNotifier {
  static CHome get(BuildContext context) =>
      Provider.of<CHome>(context, listen: false);
  final _sHome = getIt<SHome>();

  Future<Message?> uploadImage(String imagePath) async {
    try {
      final result = await _sHome.uploadImage(imagePath);
      if (result.isRight) {
        final message = Message.fromMap((result as Right).value);
        return message;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
