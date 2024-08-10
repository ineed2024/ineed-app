import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:Ineed/di/di.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = AppControllerBase with _$AppController;

abstract class AppControllerBase with Store {
  final sharedPreferences = getIt.get<SharedPreferencesManager>();

  @observable
  bool loading = true;

  String initRouter = '/';
}
