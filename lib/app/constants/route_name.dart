class RouteName {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String solicitation = '/solicitation';
  static const String user = '/user';

  static const String cards = '$user/cards';
  static const String userCards = '$cards-$list';

  static const String evaluation = '/evaluation';
  static const String coupon = '$user/coupons';
  static const String updatePassword = '$user/updatePassword';

  static const String menu = '$dashboard/menu';

  static const String forgotPassword = '/forgot_password';
  static const String register = '/register';

  static const String chooseService = '$dashboard/choose-service';

  static const String solicitationCreate = '$solicitation/solicitation-$create';
  static const String solicitationDetail = '$solicitation/solicitation-$detail';
  static const String solicitationList = '$solicitation/solicitation-$list';
  static const String createCard = '$cards/$create';

  static const String userUpdateField = '$user/update-field';
  static const String userAddress = '$user/address';

  static const String create = 'create';
  static const String detail = 'detail';
  static const String list = 'list';
}
