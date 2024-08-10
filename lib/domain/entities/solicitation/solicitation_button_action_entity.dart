import 'package:Ineed/app/constants/solicitation_button_action_type.dart';
import 'package:flutter/material.dart';

class SolicitationButtonActionEntity {
  final bool? visibility;
  final bool? enabled;
  final SolicitationButtonActionType? type;
  bool? loading;

  SolicitationButtonActionEntity(
      {this.visibility, this.enabled = false, this.type, this.loading = false});

  SolicitationButtonActionEntity copyWith(
      {bool? visibility,
      Function? action,
      SolicitationButtonActionType? type,
      bool? loading,
      bool? enabled}) {
    return SolicitationButtonActionEntity(
        visibility: visibility ?? this.visibility,
        type: type ?? this.type,
        loading: loading ?? this.loading,
        enabled: enabled ?? this.enabled);
  }
}
