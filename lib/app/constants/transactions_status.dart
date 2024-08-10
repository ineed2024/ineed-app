enum TransactionsStatus {
  waiting_for_payment,
  in_analysis,
  pay,
  available,
  in_dispute,
  returned,
  canceled,
  debit,
  retention
}

extension TransactionsStatusExtensions on TransactionsStatus {
  String nameOf() {
    switch (this) {
      case TransactionsStatus.waiting_for_payment:
        return 'Aguardando pagamento';
        break;
      case TransactionsStatus.in_analysis:
        return 'Em análise';
      case TransactionsStatus.retention:
        return 'Retenção temporária';
      case TransactionsStatus.pay:
        return 'Paga';
      case TransactionsStatus.available:
        return 'Disponível';
      case TransactionsStatus.in_dispute:
        return 'Em disputa';
      case TransactionsStatus.returned:
        return 'Devolvida';
      case TransactionsStatus.canceled:
        return 'Cancelada';
      case TransactionsStatus.debit:
        return 'Debitado';
      default:
        return 'Nenhum';
    }
  }
}
