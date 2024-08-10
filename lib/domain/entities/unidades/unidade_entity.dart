class UnidadeEntity {
  final String codImo;
  final String nomCon;

  UnidadeEntity({required this.codImo, required this.nomCon});

  static List<UnidadeEntity> fromMapList(List<dynamic> data) {
    return List.from(data)
        .map((element) => UnidadeEntity.fromJson(element))
        .toList();
  }

  factory UnidadeEntity.fromJson(Map<String, dynamic> json) {
    return UnidadeEntity(codImo: json['CODIMO'], nomCon: json['NOMCON']);
  }
}
