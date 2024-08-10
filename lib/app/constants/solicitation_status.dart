import 'package:flutter/material.dart';

enum SolicitationStatus {
  canceled,
  pending,
  extraTaxConfirmation,
  waitingEvaluation,
  waitingBudget,
  finished,
  pendingConfirmation,
  waitingVisit,
}

extension SolicitationStatusExtenstion on SolicitationStatus {
  String get valueOf {
    switch (this) {
      case SolicitationStatus.pending:
        return 'Pendente';
      case SolicitationStatus.waitingEvaluation:
        return 'Aguardando avaliação';
      case SolicitationStatus.canceled:
        return 'Cancelado';
      case SolicitationStatus.waitingVisit:
        return 'Aguardando visita';
      case SolicitationStatus.pendingConfirmation:
        return 'Confirmação pendente';
      case SolicitationStatus.extraTaxConfirmation:
        return 'Taxa Extra Pendente';
      case SolicitationStatus.waitingBudget:
        return 'Aguardando serviço';
      case SolicitationStatus.finished:
        return 'Concluído';
      default:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case SolicitationStatus.pending:
        return Color(0xffb60707);
      case SolicitationStatus.waitingEvaluation:
        return Color(0xff0770b6);
      case SolicitationStatus.pendingConfirmation:
        return Color(0xff580786);
      case SolicitationStatus.canceled:
        return Color(0xffb60707);
      case SolicitationStatus.waitingBudget:
        return Color(0xffb65607);
      default:
        return Color(0xff07b670);
    }
  }
}
