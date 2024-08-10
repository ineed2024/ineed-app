import 'dart:convert';

import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:Ineed/domain/entities/user/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:Ineed/data/mappers/auth/user_mapper.dart';

@injectable
class UserLocalDataSource {
  SharedPreferencesManager _sharedPreferences;
  UserLocalDataSource(this._sharedPreferences);
  Future<UserEntity> getUser() async {
    String? encodedMap =
        await _sharedPreferences.getString(SharedPreferencesManager.user);
    Map<String, dynamic> decodedMap = json.decode(encodedMap!);
    return UserEntity().fromMap(decodedMap);

    // return _sharedPreferences.get(SharedPreferencesManager.user);
  }

  void saveUser(UserEntity user) {
    _sharedPreferences.putMap(SharedPreferencesManager.config, user.toMap());
  }
}
