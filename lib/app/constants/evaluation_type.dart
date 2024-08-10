enum EvaluationOptions { visit, budget }

extension EvaluationOptionsExtensions on EvaluationOptions {
  int valueOf() {
    switch (this) {
      case EvaluationOptions.visit:
        return 1;
        break;
      case EvaluationOptions.budget:
        return 2;
      default:
        return 0;
    }
  }

  String messageEvalution() {
    switch (this) {
      case EvaluationOptions.budget:
        return 'Como você avalia o serviço prestado?';
        break;
      case EvaluationOptions.visit:
        return 'Como você avalia a visita?';
      default:
        return 'Nenhum';
    }
  }

  String titleToolbar() {
    switch (this) {
      case EvaluationOptions.budget:
        return 'Avaliação do serviço';
        break;
      case EvaluationOptions.visit:
        return 'Avaliação da visita';
      default:
        return 'Nenhum';
    }
  }
}
