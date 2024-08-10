import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:Ineed/domain/entities/auth/authentication_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthLocalDataSource {
  SharedPreferencesManager _sharedPreferences;
  AuthLocalDataSource(this._sharedPreferences);

  Future<String?> getToken() async {
    return _sharedPreferences.getString(SharedPreferencesManager.token);
  }

  void saveToken(AuthenticationEntity entity) {
    _sharedPreferences.putString(SharedPreferencesManager.token, entity.token!);
  }

  Future cleanDataLocal() async {
    return _sharedPreferences.removeAll();
  }
}
