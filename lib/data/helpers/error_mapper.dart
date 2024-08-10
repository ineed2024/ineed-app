import 'package:Ineed/domain/utils/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ErrorMapper {
  static AppException from(e) {
    try {
      debugPrintStack(stackTrace: e.stackTrace);
    } catch (e) {
      debugPrint(e.toString());
    }
    switch (e.runtimeType) {
      case AppException:
        return e;
      case DioException:
        return AppException(exception: e, message: _dioError(e));

      default:
        return AppException(
          exception: e,
          message: e.toString(),
        );
    }
  }

  static String? _dioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return "Falha na conexão";
      case DioExceptionType.cancel:
        return "Requisição cancelada";
      case DioExceptionType.badResponse:
      // case DioExceptionType.:
      default:
        break;
    }
    if (error.response?.statusCode != null) {
      switch (error.response!.statusCode) {
        case 401:
          return error.response!.data['message'];
        case 403:
          return 'Ocorreu um erro na requisição';
        case 404:
          return error.response!.data["error"][0];
        case 400:
          return error.response!.data["error"][0];
        case 500:
          return 'Erro no serviço, tente mais tarde';
        case 503:
          return 'Serviço indisponivel, tente mais tarde.';
        default:
          return "Ocorreu um erro na solicitação, tente novamente mais tarde";
      }
    }
    return null;
  }
}
