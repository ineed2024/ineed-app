import 'carro_entity.dart';

class ConfigList {
  final String? message;
  final int? count;
  final int? currentPage;
  final int? nextPage;
  final int? prevPage;
  final int? lastPage;
  final List<CarroEntity> carros;

  ConfigList(
      {required this.message,
      this.count,
      this.currentPage,
      this.nextPage,
      this.prevPage,
      this.lastPage,
      required this.carros});

  factory ConfigList.fromJson(Map<String, dynamic> json) {
    return ConfigList(
        message: json['message'],
        count: json['count'],
        currentPage: json['currentPage'],
        lastPage: json['lastPage'],
        nextPage: json['nextPage'],
        prevPage: json['prevPage'],
        carros: CarroEntity.fromMapList(json['data']));
  }
}
