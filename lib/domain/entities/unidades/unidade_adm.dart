class UnidadeAdmEntity {
  final int codOrd;
  final String? codImo;
  final String? nomPro;

  UnidadeAdmEntity({
    required this.codOrd,
    this.codImo,
    this.nomPro,
  });

  static List<UnidadeAdmEntity> fromMapList(List<dynamic> data) {
    return List.from(data)
        .map((element) => UnidadeAdmEntity.fromJson(element))
        .toList();
  }

  factory UnidadeAdmEntity.fromJson(Map<String, dynamic> json) {
    return UnidadeAdmEntity(
      codOrd: json['CODORD'],
      codImo: json['CODIMO'],
      nomPro: json['NOMPRO'],
    );
  }
}
