import 'package:flutter/foundation.dart';

@immutable
class CouponEntity {
  final int? id;
  final String? code;

  CouponEntity({
    this.id,
    this.code,
  });

  @override
  String toString() {
    return 'ConfigurationEntity(id: $id, code: $code)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CouponEntity && o.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
