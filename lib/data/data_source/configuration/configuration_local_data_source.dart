import 'dart:convert';

import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:Ineed/data/mappers/configuration/configuration_mapper.dart';

import '../../../domain/configurations/configuration_entity.dart';

@injectable
class ConfigurationLocalDataSource {
  SharedPreferencesManager _sharedPreferences;
  ConfigurationLocalDataSource(this._sharedPreferences);
  Future<ConfigurationEntity> getConfig() async {
    String? encodedMap =
        await _sharedPreferences.getString(SharedPreferencesManager.config);
    Map<String, dynamic> decodedMap = json.decode(encodedMap!);
    return ConfigurationEntity().fromMap(decodedMap);
  }

  void saveConfig(ConfigurationEntity entity) {
    _sharedPreferences.putMap(SharedPreferencesManager.config, entity.toMap());
  }
}
