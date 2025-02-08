import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hather_app/src/services/s_auth.dart';
import 'package:hather_app/src/services/s_home.dart';
import 'package:hather_app/src/utils/dio/dio_client.dart';
import 'package:hather_app/src/utils/local/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<DioClient>(DioClient(Dio()));

  getIt.registerSingleton<Preferences>(Preferences(sharedPreferences));
  getIt.registerSingleton<SAuth>(SAuth(getIt<Preferences>()));
  getIt.registerSingleton<SHome>(SHome(getIt<DioClient>()));

}
