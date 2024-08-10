class ResultDataNavigatorEntity<T> {
  final String? message;
  final String? namedRouter;
  final bool? closePage;
  final T? args;
  final bool? updateView;

  ResultDataNavigatorEntity({
    this.namedRouter,
    this.args,
    this.message,
    this.closePage,
    this.updateView,
  });
}
