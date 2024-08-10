import 'package:flutter/material.dart';
import 'package:Ineed/app/constants/route_name.dart';
import 'package:Ineed/data/local/shared_preferences.dart';
import 'package:Ineed/di/di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/auth/auth_local_data_source.dart';

@injectable
class AuthInterceptor extends InterceptorsWrapper {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  Future onError(DioException err, handler) async {
    if (err.response?.statusCode == 401 && err.requestOptions.path != 'login') {
      goToLogin();
    }
    if (err.response?.statusCode == 500) {
      debugPrint('teste');
    }
    return super.onError(err, handler);
  }

  goToLogin() {
    getIt.get<SharedPreferencesManager>().removeAll();
    Modular.to.pushReplacementNamed(RouteName.login,
        arguments: 'Sua sessão expirou, logue–se novamente.');
  }

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await getIt<AuthLocalDataSource>().getToken();
    if (token != null) options.headers['Authorization'] = token;
    return super.onRequest(options, handler);
  }
}
