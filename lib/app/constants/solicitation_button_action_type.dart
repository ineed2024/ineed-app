enum SolicitationButtonActionType {
  confirmVisit,
  rateVisit,
  confirmBudget,
  rateBudget,
  showExtraTax
}

extension SolicitationButtonActionTypeExtension
    on SolicitationButtonActionType {
  String get valueOf {
    switch (this) {
      case SolicitationButtonActionType.confirmVisit:
        return 'Confirmar visita';
      case SolicitationButtonActionType.rateVisit:
        return 'Avaliar visita';
      case SolicitationButtonActionType.confirmBudget:
        return 'Confirmar orçamento';
      case SolicitationButtonActionType.rateBudget:
        return 'Avaliar serviço';
      case SolicitationButtonActionType.showExtraTax:
        return 'Pagar taxa extra';
      default:
        return 'None';
    }
  }
}
